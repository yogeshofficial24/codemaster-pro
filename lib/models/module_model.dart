class ModuleModel {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final int orderIndex;
  final int totalTopics;

  ModuleModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    this.orderIndex = 0,
    this.totalTopics = 0,
  });

  factory ModuleModel.fromMap(Map<String, dynamic> map, String docId) {
    return ModuleModel(
      id: docId,
      courseId: map['courseId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      orderIndex: map['orderIndex']?.toInt() ?? 0,
      totalTopics: map['totalTopics']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'title': title,
      'description': description,
      'orderIndex': orderIndex,
      'totalTopics': totalTopics,
    };
  }
}
