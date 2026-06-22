import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/models/topic_model.dart';
import 'package:codemaster_pro/features/ai_assistant/providers/ai_repository.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';

class TopicReaderScreen extends ConsumerStatefulWidget {
  final TopicModel topic;

  const TopicReaderScreen({super.key, required this.topic});

  @override
  ConsumerState<TopicReaderScreen> createState() => _TopicReaderScreenState();
}

class _TopicReaderScreenState extends ConsumerState<TopicReaderScreen> {
  String _markdownData = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    if (widget.topic.contentMarkdown != 'DYNAMIC_AI_CONTENT') {
      setState(() {
        _markdownData = widget.topic.contentMarkdown;
        _isLoading = false;
      });
      return;
    }

    final prompt = '''
Generate a comprehensive, expert-level Markdown tutorial about "\${widget.topic.title}".
You MUST use exactly this structure and fill it out completely with rich code examples:
# \${widget.topic.title}
## 1. Introduction
## 2. Why Learn This Topic
## 3. Where It Is Used
## 4. Industry Applications
## 5. Detailed Explanation
## 6. Syntax Explanation
## 7. Beginner Examples
## 8. Intermediate Examples
## 9. Advanced Examples
## 10. Practice Programs
## 11. Output Explanation
## 12. Common Errors
## 13. Best Practices
## 14. Coding Challenges
## 15. Quiz Questions
## 16. Interview Questions
## 17. Assignment
## 18. Mini Project
## 19. Notes
## 20. Revision Points
''';

    final result = await ref.read(aiRepositoryProvider).askQuestion(prompt);
    
    if (mounted) {
      setState(() {
        _markdownData = result;
        _isLoading = false;
      });
    }
  }

  void _openAIAssistant() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundDark,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('AI Learning Assistant', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(50),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('Hello! I am your AI Assistant. You can ask me any specific doubts about this topic, ask me to explain code, or test your knowledge!'),
                      )
                    ],
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'e.g., Explain Flexbox...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send, color: AppColors.primary),
                      onPressed: () {
                        // TODO: Send specific topic doubt to AI
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('AI Doubt clearing in progress...')));
                      },
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.title),
        backgroundColor: AppColors.backgroundDark,
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Completed! +${widget.topic.xpReward} XP')),
              );
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('AI is generating a comprehensive lesson...'),
                ],
              ),
            )
          : Markdown(
              data: _markdownData,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAIAssistant,
        icon: const Icon(Icons.smart_toy),
        label: const Text('Ask AI Doubt'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
