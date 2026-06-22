class UserModel {
  final String uid;
  final String email;
  final String fullName;
  final String mobileNumber;
  final String education;
  final String currentRole;
  final String experienceLevel;
  final String targetJobRole;
  final int xpEarned;
  final int coursesCompleted;
  final String profilePicture;

  UserModel({
    required this.uid,
    required this.email,
    this.fullName = '',
    this.mobileNumber = '',
    this.education = '',
    this.currentRole = '',
    this.experienceLevel = '',
    this.targetJobRole = '',
    this.xpEarned = 0,
    this.coursesCompleted = 0,
    this.profilePicture = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'education': education,
      'currentRole': currentRole,
      'experienceLevel': experienceLevel,
      'targetJobRole': targetJobRole,
      'xpEarned': xpEarned,
      'coursesCompleted': coursesCompleted,
      'profilePicture': profilePicture,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      fullName: map['fullName'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      education: map['education'] ?? '',
      currentRole: map['currentRole'] ?? '',
      experienceLevel: map['experienceLevel'] ?? '',
      targetJobRole: map['targetJobRole'] ?? '',
      xpEarned: map['xpEarned']?.toInt() ?? 0,
      coursesCompleted: map['coursesCompleted']?.toInt() ?? 0,
      profilePicture: map['profilePicture'] ?? '',
    );
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? mobileNumber,
    String? education,
    String? currentRole,
    String? experienceLevel,
    String? targetJobRole,
    int? xpEarned,
    int? coursesCompleted,
    String? profilePicture,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      education: education ?? this.education,
      currentRole: currentRole ?? this.currentRole,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      targetJobRole: targetJobRole ?? this.targetJobRole,
      xpEarned: xpEarned ?? this.xpEarned,
      coursesCompleted: coursesCompleted ?? this.coursesCompleted,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
