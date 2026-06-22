import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:codemaster_pro/models/topic_model.dart';

class TopicReaderScreen extends StatelessWidget {
  final TopicModel topic;

  const TopicReaderScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () {
              // TODO: Mark as complete and award XP
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Completed! +${topic.xpReward} XP')),
              );
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Markdown(
        data: topic.contentMarkdown,
        padding: const EdgeInsets.all(16.0),
        styleSheet: MarkdownStyleSheet(
          h1: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          h2: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          p: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Open AI Chat Assistant for this topic
        },
        icon: const Icon(Icons.smart_toy),
        label: const Text('Ask AI'),
      ),
    );
  }
}
