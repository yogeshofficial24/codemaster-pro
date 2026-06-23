import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/models/course_model.dart';
import 'package:codemaster_pro/models/question_model.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';

class DynamicQuizScreen extends ConsumerStatefulWidget {
  final CourseModel course;
  const DynamicQuizScreen({super.key, required this.course});

  @override
  ConsumerState<DynamicQuizScreen> createState() => _DynamicQuizScreenState();
}

class _DynamicQuizScreenState extends ConsumerState<DynamicQuizScreen> {
  List<QuestionModel> _questions = [];
  bool _isLoading = true;
  String? _error;

  int _currentIndex = 0;
  int _score = 0;
  bool _isFinished = false;
  int? _selectedAnswerIndex;
  bool _isAnswerChecked = false;

  @override
  void initState() {
    super.initState();
    _generateQuiz();
  }

  Future<void> _generateQuiz() async {
    // Generate 10 offline questions for the given course.
    List<QuestionModel> generatedQuestions = [];
    
    for (int i = 1; i <= 10; i++) {
      generatedQuestions.add(
        QuestionModel(
          id: 'q$i',
          quizId: widget.course.id,
          questionText: 'What is a core concept in ${widget.course.title} (Question $i)?',
          options: [
            'A basic feature',
            'An advanced technique',
            'A deprecated property',
            'The right answer for $i',
          ],
          correctAnswerIndex: 3,
          explanation: 'This is a hardcoded offline explanation for ${widget.course.title} to test your knowledge without internet.',
        ),
      );
    }

    if (mounted) {
      setState(() {
        _questions = generatedQuestions;
        _isLoading = false;
      });
    }
  }

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

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.course.title} Quiz'),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('AI is generating 10 unique questions...'),
                ],
              ),
            )
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        Text(_error!, textAlign: TextAlign.center),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                              _error = null;
                            });
                            _generateQuiz();
                          },
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                )
              : _isFinished
                  ? _buildResultScreen()
                  : _buildQuestionScreen(),
    );
  }

  Widget _buildQuestionScreen() {
    final question = _questions[_currentIndex];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LinearProgressIndicator(
            value: (_currentIndex + 1) / _questions.length,
            backgroundColor: AppColors.surfaceDark,
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Question ${_currentIndex + 1} of ${_questions.length}',
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
              onPressed: _nextQuestion,
              child: Text(_currentIndex < _questions.length - 1 ? 'Next Question' : 'Finish Quiz'),
            ),
          ],
        ],
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

  Widget _buildResultScreen() {
    final double percentage = (_score / _questions.length) * 100;
    
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
              'You scored $_score out of ${_questions.length}',
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
              child: const Text('Back to Subjects'),
            ),
          ],
        ),
      ),
    );
  }
}
