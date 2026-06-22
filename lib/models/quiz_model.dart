class QuizModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String difficulty;
  final int timeLimitMinutes;
  final int totalQuestions;

  QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.timeLimitMinutes,
    required this.totalQuestions,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map, String docId) {
    return QuizModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      difficulty: map['difficulty'] ?? 'Beginner',
      timeLimitMinutes: map['timeLimitMinutes']?.toInt() ?? 10,
      totalQuestions: map['totalQuestions']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'timeLimitMinutes': timeLimitMinutes,
      'totalQuestions': totalQuestions,
    };
  }
}
