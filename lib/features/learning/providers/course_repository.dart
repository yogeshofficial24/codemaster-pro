import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/models/course_model.dart';
import 'package:codemaster_pro/models/module_model.dart';
import 'package:codemaster_pro/models/topic_model.dart';
import 'package:codemaster_pro/scripts/curriculum_data.dart';

final courseRepositoryProvider = Provider((ref) => CourseRepository());

final coursesProvider = StreamProvider<List<CourseModel>>((ref) {
  return ref.watch(courseRepositoryProvider).getCourses();
});

final modulesProvider = StreamProvider.family<List<ModuleModel>, String>((ref, courseId) {
  return ref.watch(courseRepositoryProvider).getModules(courseId);
});

final topicsProvider = StreamProvider.family<List<TopicModel>, String>((ref, idPair) {
  final parts = idPair.split('::');
  return ref.watch(courseRepositoryProvider).getTopics(parts[0], parts[1]);
});

class CourseRepository {
  Stream<List<CourseModel>> getCourses() async* {
    List<CourseModel> courses = [];
    for (var c in CurriculumData.masterCourses) {
      final List<String> modules = List<String>.from(c['modules']);
      courses.add(
        CourseModel(
          id: c['id'],
          title: c['title'],
          description: c['desc'],
          category: c['category'],
          totalModules: modules.length,
          imageUrl: '',
        ),
      );
    }
    yield courses;
  }

  Stream<List<ModuleModel>> getModules(String courseId) async* {
    List<ModuleModel> moduleModels = [];
    final courseData = CurriculumData.masterCourses.firstWhere(
      (element) => element['id'] == courseId,
      orElse: () => {},
    );

    if (courseData.isNotEmpty) {
      final List<String> modules = List<String>.from(courseData['modules']);
      for (int i = 0; i < modules.length; i++) {
        moduleModels.add(
          ModuleModel(
            id: 'mod_$i',
            courseId: courseId,
            title: modules[i],
            description: 'Learn about ${modules[i]}',
            orderIndex: i,
            totalTopics: 1, // Let's give every module 1 mega-topic for simplicity in offline mode
          ),
        );
      }
    }
    yield moduleModels;
  }

  Stream<List<TopicModel>> getTopics(String courseId, String moduleId) async* {
    List<TopicModel> topicModels = [];
    final courseData = CurriculumData.masterCourses.firstWhere(
      (element) => element['id'] == courseId,
      orElse: () => {},
    );

    if (courseData.isNotEmpty) {
      final List<String> modules = List<String>.from(courseData['modules']);
      final modIndex = int.tryParse(moduleId.replaceAll('mod_', '')) ?? 0;
      if (modIndex >= 0 && modIndex < modules.length) {
        final moduleTitle = modules[modIndex];
        topicModels.add(
          TopicModel(
            id: 'top_0',
            moduleId: moduleId,
            title: moduleTitle,
            contentMarkdown: _generateDefaultContent(moduleTitle),
            orderIndex: 0,
            xpReward: 10,
          ),
        );
      }
    }
    yield topicModels;
  }

  String _generateDefaultContent(String title) {
    return '''
# \$title

Welcome to this comprehensive guide on **\$title**. This module is designed to give you a deep understanding of the concepts and practical applications.

## Overview
Understanding **\$title** is crucial for modern development. It forms the backbone of many professional architectures and workflows.

### Key Concepts
*   **Fundamentals**: Grasp the core syntax and basic principles.
*   **Best Practices**: Learn how the industry utilizes these patterns.
*   **Common Pitfalls**: What to avoid when writing production code.

### Practical Example
```javascript
// A simple boilerplate example
function init() {
  console.log("Mastering \$title");
}
init();
```

## Summary
You have now completed the reading for **\$title**. Make sure to practice the concepts and take the quiz to test your knowledge!
''';
  }
}

