import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codemaster_pro/models/course_model.dart';
import 'package:codemaster_pro/models/module_model.dart';
import 'package:codemaster_pro/models/topic_model.dart';
import 'package:codemaster_pro/models/quiz_model.dart';
import 'package:codemaster_pro/models/question_model.dart';

class DatabaseSeeder {
  static Future<void> seedData() async {
    final firestore = FirebaseFirestore.instance;

    // 1. Add Python Course
    final pythonDoc = firestore.collection('courses').doc('python_mastery');
    await pythonDoc.set(CourseModel(
      id: 'python_mastery',
      title: 'Python Mastery',
      description: 'Learn Python from scratch to advanced concepts.',
      category: 'Backend',
      totalModules: 2,
    ).toMap());

    // Python Module 1
    final pMod1 = pythonDoc.collection('modules').doc('mod_1');
    await pMod1.set(ModuleModel(
      id: 'mod_1',
      courseId: 'python_mastery',
      title: 'Getting Started',
      description: 'Introduction to Python and basic syntax.',
      orderIndex: 1,
      totalTopics: 2,
    ).toMap());

    // Python Topics
    await pMod1.collection('topics').doc('t_1').set(TopicModel(
      id: 't_1',
      moduleId: 'mod_1',
      title: 'Variables and Data Types',
      contentMarkdown: '''
# Variables in Python
In Python, you don't need to declare a variable's type.
```python
x = 5
name = "Alice"
print(x)
```
''',
      orderIndex: 1,
      xpReward: 10,
    ).toMap());

    await pMod1.collection('topics').doc('t_2').set(TopicModel(
      id: 't_2',
      moduleId: 'mod_1',
      title: 'Control Flow',
      contentMarkdown: '''
# If Statements
```python
if x > 0:
    print("Positive")
else:
    print("Negative")
```
''',
      orderIndex: 2,
      xpReward: 15,
    ).toMap());


    // 2. Add JavaScript Course
    final jsDoc = firestore.collection('courses').doc('js_essentials');
    await jsDoc.set(CourseModel(
      id: 'js_essentials',
      title: 'JavaScript Essentials',
      description: 'Master the language of the web.',
      category: 'Frontend',
      totalModules: 1,
    ).toMap());

    // JS Module
    final jMod1 = jsDoc.collection('modules').doc('mod_1');
    await jMod1.set(ModuleModel(
      id: 'mod_1',
      courseId: 'js_essentials',
      title: 'JS Basics',
      description: 'Core concepts of JavaScript.',
      orderIndex: 1,
      totalTopics: 1,
    ).toMap());

    await jMod1.collection('topics').doc('t_1').set(TopicModel(
      id: 't_1',
      moduleId: 'mod_1',
      title: 'Functions & Arrow Functions',
      contentMarkdown: '''
# Arrow Functions
```javascript
const add = (a, b) => a + b;
console.log(add(2, 3));
```
''',
      orderIndex: 1,
      xpReward: 10,
    ).toMap());

    // 3. Add a Sample Quiz
    final quizDoc = firestore.collection('quizzes').doc('python_basics_quiz');
    await quizDoc.set(QuizModel(
      id: 'python_basics_quiz',
      title: 'Python Basics Quiz',
      description: 'Test your knowledge on Python variables and syntax.',
      category: 'Python',
      difficulty: 'Beginner',
      timeLimitMinutes: 5,
      totalQuestions: 2,
    ).toMap());

    await quizDoc.collection('questions').doc('q_1').set(QuestionModel(
      id: 'q_1',
      quizId: 'python_basics_quiz',
      questionText: 'How do you define a function in Python?',
      options: ['function myFunc()', 'def myFunc():', 'void myFunc()', 'create myFunc()'],
      correctAnswerIndex: 1,
      explanation: 'In Python, the keyword "def" is used to define a function.',
    ).toMap());

    await quizDoc.collection('questions').doc('q_2').set(QuestionModel(
      id: 'q_2',
      quizId: 'python_basics_quiz',
      questionText: 'Which of the following is a mutable data type in Python?',
      options: ['Tuple', 'String', 'List', 'Integer'],
      correctAnswerIndex: 2,
      explanation: 'Lists are mutable, meaning their contents can be changed after creation.',
    ).toMap());

  }
}
