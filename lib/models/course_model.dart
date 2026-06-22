class CourseModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category; // e.g., 'Frontend', 'Backend'
  final int totalModules;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl = '',
    this.category = 'Programming',
    this.totalModules = 0,
  });

  factory CourseModel.fromMap(Map<String, dynamic> map, String docId) {
    return CourseModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? 'Programming',
      totalModules: map['totalModules']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'totalModules': totalModules,
    };
  }
}
