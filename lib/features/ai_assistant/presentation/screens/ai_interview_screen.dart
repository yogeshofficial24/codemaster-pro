import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';
import 'package:codemaster_pro/features/ai_assistant/providers/ai_repository.dart';
import 'package:codemaster_pro/core/widgets/glassmorphism_card.dart';

class AIInterviewScreen extends ConsumerStatefulWidget {
  final String? topic;
  const AIInterviewScreen({super.key, this.topic});

  @override
  ConsumerState<AIInterviewScreen> createState() => _AIInterviewScreenState();
}

class _AIInterviewScreenState extends ConsumerState<AIInterviewScreen> {
  final TextEditingController _answerController = TextEditingController();
  
  String _selectedTopic = 'Flutter';
  String _selectedDifficulty = 'Intermediate';
  
  bool _isLoading = false;
  String? _currentQuestion;
  String? _evaluation;

  final List<String> _topics = ['Flutter', 'Dart', 'React', 'JavaScript', 'Python', 'Java', 'Data Structures'];
  final List<String> _difficulties = ['Beginner', 'Intermediate', 'Advanced'];

  Future<void> _generateQuestion() async {
    setState(() {
      _isLoading = true;
      _currentQuestion = null;
      _evaluation = null;
      _answerController.clear();
    });

    final aiRepo = ref.read(aiRepositoryProvider);
    final topicToUse = widget.topic ?? _selectedTopic;
    final question = await aiRepo.getInterviewQuestion(topicToUse, _selectedDifficulty);

    if (mounted) {
      setState(() {
        _currentQuestion = question;
        _isLoading = false;
      });
    }
  }

  Future<void> _submitAnswer() async {
    final answer = _answerController.text.trim();
    if (answer.isEmpty || _currentQuestion == null) return;

    setState(() {
      _isLoading = true;
    });

    final aiRepo = ref.read(aiRepositoryProvider);
    final eval = await aiRepo.evaluateInterviewAnswer(_currentQuestion!, answer);

    if (mounted) {
      setState(() {
        _evaluation = eval;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Interview Coach'),
        backgroundColor: AppColors.backgroundDark,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GlassmorphismCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Topic & Difficulty', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (widget.topic == null)
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedTopic,
                            decoration: const InputDecoration(labelText: 'Topic', filled: true),
                            items: _topics.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                            onChanged: (val) => setState(() => _selectedTopic = val!),
                          ),
                        ),
                      if (widget.topic == null)
                        const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedDifficulty,
                          decoration: const InputDecoration(labelText: 'Difficulty', filled: true),
                          items: _difficulties.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                          onChanged: (val) => setState(() => _selectedDifficulty = val!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _generateQuestion,
                      icon: const Icon(Icons.psychology),
                      label: const Text('Generate Question'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (_isLoading)
              const Center(child: CircularProgressIndicator()),
            
            if (_currentQuestion != null && !_isLoading) ...[
              const Text('Question:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withAlpha(50)),
                ),
                child: MarkdownBody(data: _currentQuestion!),
              ),
              const SizedBox(height: 24),
              if (_evaluation == null) ...[
                TextField(
                  controller: _answerController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Your Answer',
                    hintText: 'Type your answer here...',
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitAnswer,
                  child: const Text('Submit Answer for Evaluation'),
                ),
              ] else ...[
                const Text('AI Evaluation:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withAlpha(50)),
                  ),
                  child: MarkdownBody(data: _evaluation!),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: _generateQuestion,
                  child: const Text('Try Another Question'),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
