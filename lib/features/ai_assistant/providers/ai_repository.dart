import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// IMPORTANT: Never hardcode API keys in a production app. 
// For this MVP, we will use a placeholder. The user must provide their own key.
const String _apiKey = 'PLACEHOLDER_API_KEY';

final aiRepositoryProvider = Provider((ref) => AIRepository());

class AIRepository {
  late final GenerativeModel _model;

  AIRepository() {
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);
  }

  Future<String> askQuestion(String prompt) async {
    if (_apiKey == 'PLACEHOLDER_API_KEY') {
      return 'Please configure your Gemini API Key in lib/features/ai_assistant/providers/ai_repository.dart to use this feature.';
    }
    
    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? 'I could not generate an answer.';
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> getInterviewQuestion(String topic, String difficulty) async {
    final prompt = 'Act as an expert technical interviewer. Ask a $difficulty level interview question about $topic. Do not provide the answer, just the question.';
    return await askQuestion(prompt);
  }

  Future<String> evaluateInterviewAnswer(String question, String answer) async {
    final prompt = 'As an expert technical interviewer, evaluate this answer to the following question. \nQuestion: $question\nAnswer: $answer\n\nProvide a brief evaluation, a score out of 10, and what could be improved.';
    return await askQuestion(prompt);
  }
}
