import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codemaster_pro/models/course_model.dart';
import 'package:codemaster_pro/models/module_model.dart';
import 'package:codemaster_pro/models/topic_model.dart';
import 'package:flutter/foundation.dart';
import 'package:codemaster_pro/scripts/curriculum_data.dart';

class DatabaseSeeder {
  static Future<void> seedData() async {
    final firestore = FirebaseFirestore.instance;

    debugPrint("Clearing old data...");
    
    debugPrint("Seeding \${CurriculumData.masterCourses.length} Master Courses...");

    // Use WriteBatch to drastically speed up 1500+ writes
    WriteBatch batch = firestore.batch();
    int operationCount = 0;

    for (var courseMap in CurriculumData.masterCourses) {
      final String cId = courseMap['id'];
      
      final List<String> moduleNames = courseMap['modules'] as List<String>;

      final courseRef = firestore.collection('courses').doc(cId);
      batch.set(courseRef, CourseModel(
        id: cId,
        title: courseMap['title'],
        description: courseMap['desc'],
        category: courseMap['category'],
        totalModules: moduleNames.length,
      ).toMap());
      operationCount++;

      int modIndex = 1;
      for (var modName in moduleNames) {
        final String mId = 'mod_\$modIndex';
        final modRef = courseRef.collection('modules').doc(mId);
        
        batch.set(modRef, ModuleModel(
          id: mId,
          courseId: cId,
          title: modName,
          description: "Master \${courseMap['title']} concepts focusing on \$modName.",
          orderIndex: modIndex,
          totalTopics: 3, 
        ).toMap());
        operationCount++;

        final standardTopics = [
          'Theory & Fundamentals of \$modName',
          'Code Examples & Patterns for \$modName',
          'Advanced Use Cases for \$modName',
        ];

        int topIndex = 1;
        for (var topicTitle in standardTopics) {
          final String tId = 't_\$topIndex';
          final topRef = modRef.collection('topics').doc(tId);
          
          batch.set(topRef, TopicModel(
            id: tId,
            moduleId: mId,
            title: topicTitle,
            contentMarkdown: 'DYNAMIC_AI_CONTENT', 
            orderIndex: topIndex,
            xpReward: 20 + (modIndex * 5),
          ).toMap());
          operationCount++;

          // Commit batch if we reach the 500 operation limit
          if (operationCount >= 450) {
            await batch.commit();
            batch = firestore.batch();
            operationCount = 0;
          }
          topIndex++;
        }
        modIndex++;
      }
    }
    
    // Commit any remaining operations
    if (operationCount > 0) {
      await batch.commit();
    }
    
    debugPrint("Finished Seeding Master Database with \${CurriculumData.masterCourses.length} Languages!");
  }
}
