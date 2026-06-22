class LanguageProgressModel {
  final String languageId;
  final String languageName;
  final int progressPercentage;
  final int modulesCompleted;
  final int totalModules;
  final int timeSpentHours;
  final int quizScoreAvg;
  final int interviewReadiness;

  LanguageProgressModel({
    required this.languageId,
    required this.languageName,
    this.progressPercentage = 0,
    this.modulesCompleted = 0,
    this.totalModules = 0,
    this.timeSpentHours = 0,
    this.quizScoreAvg = 0,
    this.interviewReadiness = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'languageId': languageId,
      'languageName': languageName,
      'progressPercentage': progressPercentage,
      'modulesCompleted': modulesCompleted,
      'totalModules': totalModules,
      'timeSpentHours': timeSpentHours,
      'quizScoreAvg': quizScoreAvg,
      'interviewReadiness': interviewReadiness,
    };
  }

  factory LanguageProgressModel.fromMap(Map<String, dynamic> map) {
    return LanguageProgressModel(
      languageId: map['languageId'] ?? '',
      languageName: map['languageName'] ?? '',
      progressPercentage: map['progressPercentage']?.toInt() ?? 0,
      modulesCompleted: map['modulesCompleted']?.toInt() ?? 0,
      totalModules: map['totalModules']?.toInt() ?? 0,
      timeSpentHours: map['timeSpentHours']?.toInt() ?? 0,
      quizScoreAvg: map['quizScoreAvg']?.toInt() ?? 0,
      interviewReadiness: map['interviewReadiness']?.toInt() ?? 0,
    );
  }
}
