class TopicModel {
  final String id;
  final String moduleId;
  final String title;
  final String contentMarkdown;
  final int orderIndex;
  final int xpReward;

  TopicModel({
    required this.id,
    required this.moduleId,
    required this.title,
    required this.contentMarkdown,
    this.orderIndex = 0,
    this.xpReward = 10,
  });

  factory TopicModel.fromMap(Map<String, dynamic> map, String docId) {
    return TopicModel(
      id: docId,
      moduleId: map['moduleId'] ?? '',
      title: map['title'] ?? '',
      contentMarkdown: map['contentMarkdown'] ?? '',
      orderIndex: map['orderIndex']?.toInt() ?? 0,
      xpReward: map['xpReward']?.toInt() ?? 10,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'moduleId': moduleId,
      'title': title,
      'contentMarkdown': contentMarkdown,
      'orderIndex': orderIndex,
      'xpReward': xpReward,
    };
  }
}
