import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user_model.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

class UserRepository {
  static const _userKey = 'local_user_profile';

  Future<void> saveUserProfile(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toMap()));
  }

  Future<UserModel?> getUserProfile(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString != null) {
      final map = jsonDecode(userString) as Map<String, dynamic>;
      return UserModel.fromMap(map);
    }
    
    // Return a default local user if none exists
    return UserModel(
      uid: 'local_user',
      email: 'developer@codemaster.app',
      fullName: 'Developer',
    );
  }

  Future<void> addXP(int amount) async {
    final user = await getUserProfile('local_user');
    if (user != null) {
      final updatedUser = user.copyWith(xpEarned: user.xpEarned + amount);
      await saveUserProfile(updatedUser);
    }
  }

  Future<void> incrementCourseCompleted() async {
    final user = await getUserProfile('local_user');
    if (user != null) {
      final updatedUser = user.copyWith(coursesCompleted: user.coursesCompleted + 1);
      await saveUserProfile(updatedUser);
    }
  }
}
