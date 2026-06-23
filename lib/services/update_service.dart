import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateService {
  static const String githubRepo = 'yogeshofficial24/codemaster-pro';
  
  static Future<void> checkForUpdates(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse('https://api.github.com/repos/\$githubRepo/releases/latest'));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final latestVersion = data['tag_name']?.toString().replaceAll('v', '') ?? '0.0.0';
        final releaseNotes = data['body'] ?? 'Minor bug fixes and improvements.';
        
        // Find APK asset URL
        String apkUrl = '';
        if (data['assets'] != null) {
          for (var asset in data['assets']) {
            if (asset['name'].toString().endsWith('.apk')) {
              apkUrl = asset['browser_download_url'];
              break;
            }
          }
        }
        
        if (apkUrl.isEmpty) {
          // Fallback to release page HTML URL
          apkUrl = data['html_url'];
        }

        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = packageInfo.version;

        if (_isUpdateAvailable(currentVersion, latestVersion)) {
          if (context.mounted) {
            _showUpdateDialog(context, latestVersion, releaseNotes, apkUrl);
          }
        }
      }
    } catch (e) {
      // Ignore update check errors to not annoy the user
      debugPrint('Update check failed: \$e');
    }
  }

  static bool _isUpdateAvailable(String currentVersion, String latestVersion) {
    List<int> currentParts = currentVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    List<int> latestParts = latestVersion.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    for (int i = 0; i < 3; i++) {
      int current = currentParts.length > i ? currentParts[i] : 0;
      int latest = latestParts.length > i ? latestParts[i] : 0;
      
      if (latest > current) return true;
      if (latest < current) return false;
    }
    return false;
  }

  static void _showUpdateDialog(BuildContext context, String newVersion, String releaseNotes, String downloadUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Available! (v\$newVersion)'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("A new version of CodeMaster Pro is available!\\n\\nWhat's New:"),
                const SizedBox(height: 8),
                Text(releaseNotes, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Later', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () async {
                final uri = Uri.parse(downloadUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: const Text('Download Update'),
            ),
          ],
        );
      },
    );
  }
}
