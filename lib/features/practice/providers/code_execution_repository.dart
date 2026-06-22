import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final codeExecutionRepositoryProvider = Provider((ref) => CodeExecutionRepository());

class CodeExecutionRepository {
  static const String _pistonApiUrl = 'https://emacsx.com/api/v2/execute';

  Future<String> executeCode(String language, String sourceCode) async {
    // Map our display language names to Piston language identifiers
    String langId = language.toLowerCase();
    String version = '*'; // Use latest available
    
    if (langId == 'python') {
      langId = 'python';
      version = '3.10.0';
    } else if (langId == 'javascript') {
      langId = 'javascript';
      version = '18.15.0';
    } else if (langId == 'java') {
      langId = 'java';
      version = '15.0.2';
    } else if (langId == 'dart') {
      langId = 'dart';
      version = '2.19.6';
    }

    try {
      final response = await http.post(
        Uri.parse(_pistonApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'language': langId,
          'version': version,
          'files': [
            {'content': sourceCode}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['run'] != null) {
          final output = data['run']['output'] as String;
          return output.isNotEmpty ? output : 'Code executed successfully with no output.';
        }
        return 'Execution finished, but no output was returned.';
      } else {
        return 'Error executing code: HTTP ${response.statusCode}\n${response.body}';
      }
    } catch (e) {
      return 'Failed to execute code.\nMake sure you have an active internet connection.\nError: $e';
    }
  }
}
