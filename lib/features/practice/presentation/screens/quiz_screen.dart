import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/models/quiz_model.dart';
import 'package:codemaster_pro/models/question_model.dart';
import 'package:codemaster_pro/features/practice/providers/quiz_repository.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';

class QuizScreen extends ConsumerStatefulWidget {
  final QuizModel quiz;
  const QuizScreen({super.key, required this.quiz});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _isFinished = false;
  int? _selectedAnswerIndex;
  bool _isAnswerChecked = false;

  void _checkAnswer(QuestionModel question, int selectedIndex) {
    if (_isAnswerChecked) return;

    setState(() {
      _selectedAnswerIndex = selectedIndex;
      _isAnswerChecked = true;
      if (selectedIndex == question.correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion(int totalQuestions) {
    if (_currentIndex < totalQuestions - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswerIndex = null;
        _isAnswerChecked = false;
      });
    } else {
      setState(() {
        _isFinished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionsAsync = ref.watch(questionsProvider(widget.quiz.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
      ),
      body: questionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (questions) {
          if (questions.isEmpty) {
            return const Center(child: Text('No questions found.'));
          }

          if (_isFinished) {
            return _buildResultScreen(questions.length);
          }

          final question = questions[_currentIndex];

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LinearProgressIndicator(
                  value: (_currentIndex + 1) / questions.length,
                  backgroundColor: AppColors.surfaceDark,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Question ${_currentIndex + 1} of ${questions.length}',
                  style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Text(
                  question.questionText,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                ...List.generate(question.options.length, (index) {
                  return _buildOptionButton(question, index);
                }),
                const Spacer(),
                if (_isAnswerChecked) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Explanation:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                        const SizedBox(height: 8),
                        Text(question.explanation),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _nextQuestion(questions.length),
                    child: Text(_currentIndex < questions.length - 1 ? 'Next Question' : 'Finish Quiz'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOptionButton(QuestionModel question, int index) {
    Color buttonColor = AppColors.surfaceDark;
    Color borderColor = Colors.transparent;

    if (_isAnswerChecked) {
      if (index == question.correctAnswerIndex) {
        buttonColor = Colors.green.withAlpha(30);
        borderColor = Colors.green;
      } else if (index == _selectedAnswerIndex) {
        buttonColor = Colors.red.withAlpha(30);
        borderColor = Colors.red;
      }
    } else if (_selectedAnswerIndex == index) {
      buttonColor = AppColors.primary.withAlpha(50);
      borderColor = AppColors.primary;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => _checkAnswer(question, index),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(child: Text(question.options[index], style: const TextStyle(fontSize: 16))),
              if (_isAnswerChecked && index == question.correctAnswerIndex)
                const Icon(Icons.check_circle, color: Colors.green),
              if (_isAnswerChecked && index == _selectedAnswerIndex && index != question.correctAnswerIndex)
                const Icon(Icons.cancel, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultScreen(int totalQuestions) {
    final double percentage = (_score / totalQuestions) * 100;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber, size: 80),
            const SizedBox(height: 24),
            Text(
              'Quiz Completed!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'You scored $_score out of $totalQuestions',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              '${percentage.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 32, 
                fontWeight: FontWeight.bold, 
                color: percentage >= 70 ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Quizzes'),
            ),
          ],
        ),
      ),
    );
  }
}
