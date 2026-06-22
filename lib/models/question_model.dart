class QuestionModel {
  final String id;
  final String quizId;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  QuestionModel({
    required this.id,
    required this.quizId,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map, String docId) {
    return QuestionModel(
      id: docId,
      quizId: map['quizId'] ?? '',
      questionText: map['questionText'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctAnswerIndex: map['correctAnswerIndex']?.toInt() ?? 0,
      explanation: map['explanation'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'questionText': questionText,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
    };
  }
}
