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
    
    debugPrint("Seeding ${CurriculumData.masterCourses.length} Master Courses...");

    for (var courseMap in CurriculumData.masterCourses) {
      final String cId = courseMap['id'];
      
      final List<String> moduleNames = courseMap['modules'] as List<String>;

      final courseRef = firestore.collection('courses').doc(cId);
      await courseRef.set(CourseModel(
        id: cId,
        title: courseMap['title'],
        description: courseMap['desc'],
        category: courseMap['category'],
        totalModules: moduleNames.length,
      ).toMap());

      int modIndex = 1;
      for (var modName in moduleNames) {
        final String mId = 'mod_\$modIndex';
        final modRef = courseRef.collection('modules').doc(mId);
        
        await modRef.set(ModuleModel(
          id: mId,
          courseId: cId,
          title: modName,
          description: "Master ${courseMap['title']} concepts focusing on \$modName.",
          orderIndex: modIndex,
          totalTopics: 3, // 3 standard AI generated topics per module
        ).toMap());

        // We automatically generate 3 sub-topics per module for the AI to elaborate on
        final standardTopics = [
          'Theory & Fundamentals of \$modName',
          'Code Examples & Patterns for \$modName',
          'Advanced Use Cases for \$modName',
        ];

        int topIndex = 1;
        for (var topicTitle in standardTopics) {
          final String tId = 't_\$topIndex';
          final topRef = modRef.collection('topics').doc(tId);
          
          await topRef.set(TopicModel(
            id: tId,
            moduleId: mId,
            title: topicTitle,
            contentMarkdown: 'DYNAMIC_AI_CONTENT', 
            orderIndex: topIndex,
            xpReward: 20 + (modIndex * 5),
          ).toMap());
          topIndex++;
        }
        modIndex++;
      }
    }
    
    debugPrint("Finished Seeding Master Database with ${CurriculumData.masterCourses.length} Languages!");
  }
}
