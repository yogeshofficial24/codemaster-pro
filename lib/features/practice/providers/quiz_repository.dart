import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/models/quiz_model.dart';
import 'package:codemaster_pro/models/question_model.dart';

final quizRepositoryProvider = Provider((ref) => QuizRepository(FirebaseFirestore.instance));

final quizzesProvider = StreamProvider<List<QuizModel>>((ref) {
  return ref.watch(quizRepositoryProvider).getQuizzes();
});

final questionsProvider = StreamProvider.family<List<QuestionModel>, String>((ref, quizId) {
  return ref.watch(quizRepositoryProvider).getQuestions(quizId);
});

class QuizRepository {
  final FirebaseFirestore _firestore;

  QuizRepository(this._firestore);

  Stream<List<QuizModel>> getQuizzes() {
    return _firestore.collection('quizzes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => QuizModel.fromMap(doc.data(), doc.id)).toList();
    });
  }

  Stream<List<QuestionModel>> getQuestions(String quizId) {
    return _firestore
        .collection('quizzes')
        .doc(quizId)
        .collection('questions')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => QuestionModel.fromMap(doc.data(), doc.id)).toList();
    });
  }
}
