import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/models/topic_model.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';
import 'package:codemaster_pro/features/learning/providers/progress_repository.dart';
import 'package:codemaster_pro/features/auth/providers/user_repository.dart';

class TopicReaderScreen extends ConsumerWidget {
  final TopicModel topic;
  final String courseId;

  const TopicReaderScreen({super.key, required this.topic, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
        backgroundColor: AppColors.backgroundDark,
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () async {
              // Mark progress locally
              await ref.read(progressRepositoryProvider).markModuleCompleted(courseId, topic.moduleId);
              await ref.read(userRepositoryProvider).addXP(topic.xpReward);
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Completed! +${topic.xpReward} XP')),
                );
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: Markdown(
        data: topic.contentMarkdown,
        padding: const EdgeInsets.all(16.0),
        styleSheet: MarkdownStyleSheet(
          h1: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
          h2: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          p: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5, color: Colors.grey[300]),
          code: const TextStyle(
            fontFamily: 'monospace',
            backgroundColor: Color(0x336C63FF),
          ),
          codeblockDecoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

