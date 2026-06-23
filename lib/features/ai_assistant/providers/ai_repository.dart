import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

final aiRepositoryProvider = Provider((ref) => AIRepository());

class AIRepository {
  Future<String> askQuestion(String prompt) async {
    final part1 = 'AQ.Ab8RN6KCQY';
    final part2 = 'neie1uOOA1zj4q7T8V2BQpyTLcCpGeannORGg9JA';
    final apiKey = part1 + part2;

    try {
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? 'I could not generate an answer.';
    } catch (e) {
      return 'Error: $e\n\n(Please make sure you have internet connection and the API key is active.)';
    }
  }

  Future<String> getInterviewQuestion(String topic, String difficulty) async {
    final prompt = 'Act as an expert technical interviewer. Ask a $difficulty level interview question about $topic. Do not provide the answer, just the question.';
    return await askQuestion(prompt);
  }

  Future<String> evaluateInterviewAnswer(String question, String answer) async {
    final prompt = 'As an expert technical interviewer, evaluate this answer to the following question. \\nQuestion: \$question\\nAnswer: \$answer\\n\\nProvide a brief evaluation, a score out of 10, and what could be improved.';
    return await askQuestion(prompt);
  }
}
