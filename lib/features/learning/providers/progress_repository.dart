import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final progressRepositoryProvider = Provider((ref) => ProgressRepository());

class ProgressRepository {
  static const _prefix = 'completed_module_';

  Future<void> markModuleCompleted(String courseId, String moduleId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_prefix${courseId}_$moduleId', true);
    
    // Also track total completed count for this course
    final countKey = 'course_completed_count_$courseId';
    final currentCount = prefs.getInt(countKey) ?? 0;
    
    // Check if this module wasn't already tracked
    final previouslyTracked = prefs.getBool('tracked_${courseId}_$moduleId') ?? false;
    if (!previouslyTracked) {
      await prefs.setBool('tracked_${courseId}_$moduleId', true);
      await prefs.setInt(countKey, currentCount + 1);
    }
  }

  Future<bool> isModuleCompleted(String courseId, String moduleId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_prefix${courseId}_$moduleId') ?? false;
  }

  Future<int> getCompletedModulesCount(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('course_completed_count_$courseId') ?? 0;
  }
}
