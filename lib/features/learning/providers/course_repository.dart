import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/models/course_model.dart';
import 'package:codemaster_pro/models/module_model.dart';
import 'package:codemaster_pro/models/topic_model.dart';

final courseRepositoryProvider = Provider((ref) => CourseRepository(FirebaseFirestore.instance));

final coursesProvider = StreamProvider<List<CourseModel>>((ref) {
  return ref.watch(courseRepositoryProvider).getCourses();
});

final modulesProvider = StreamProvider.family<List<ModuleModel>, String>((ref, courseId) {
  return ref.watch(courseRepositoryProvider).getModules(courseId);
});

final topicsProvider = StreamProvider.family<List<TopicModel>, Map<String, String>>((ref, ids) {
  return ref.watch(courseRepositoryProvider).getTopics(ids['courseId']!, ids['moduleId']!);
});

class CourseRepository {
  final FirebaseFirestore _firestore;

  CourseRepository(this._firestore);

  Stream<List<CourseModel>> getCourses() {
    return _firestore.collection('courses').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CourseModel.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Stream<List<ModuleModel>> getModules(String courseId) {
    return _firestore
        .collection('courses')
        .doc(courseId)
        .collection('modules')
        .orderBy('orderIndex')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ModuleModel.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Stream<List<TopicModel>> getTopics(String courseId, String moduleId) {
    return _firestore
        .collection('courses')
        .doc(courseId)
        .collection('modules')
        .doc(moduleId)
        .collection('topics')
        .orderBy('orderIndex')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => TopicModel.fromMap(doc.data(), doc.id)).toList();
    });
  }
}
