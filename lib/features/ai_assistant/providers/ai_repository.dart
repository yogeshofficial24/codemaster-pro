import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

final aiRepositoryProvider = FutureProvider((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final apiKey = prefs.getString('gemini_api_key') ?? '';
  return AIRepository(apiKey);
});

class AIRepository {
  final String _apiKey;
  late final GenerativeModel? _model;

  AIRepository(this._apiKey) {
    if (_apiKey.isNotEmpty) {
      _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);
    } else {
      _model = null;
    }
  }

  Future<String> askQuestion(String prompt) async {
    if (_model == null) {
      return 'API Key not found! Please go to Settings and enter your Gemini API Key.';
    }
    
    try {
      final response = await _model!.generateContent([Content.text(prompt)]);
      return response.text ?? 'I could not generate an answer.';
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> getInterviewQuestion(String topic, String difficulty) async {
    final prompt = 'Act as an expert technical interviewer. Ask a \$difficulty level interview question about \$topic. Do not provide the answer, just the question.';
    return await askQuestion(prompt);
  }

  Future<String> evaluateInterviewAnswer(String question, String answer) async {
    final prompt = 'As an expert technical interviewer, evaluate this answer to the following question. \\nQuestion: \$question\\nAnswer: \$answer\\n\\nProvide a brief evaluation, a score out of 10, and what could be improved.';
    return await askQuestion(prompt);
  }
}
