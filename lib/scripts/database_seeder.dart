import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codemaster_pro/models/course_model.dart';
import 'package:codemaster_pro/models/module_model.dart';
import 'package:codemaster_pro/models/topic_model.dart';
import 'package:flutter/foundation.dart';

class DatabaseSeeder {
  static final List<Map<String, dynamic>> _courseData = [
    // Frontend
    {'id': 'html', 'title': 'HTML', 'category': 'Frontend', 'desc': 'HyperText Markup Language'},
    {'id': 'css', 'title': 'CSS', 'category': 'Frontend', 'desc': 'Cascading Style Sheets'},
    {'id': 'javascript', 'title': 'JavaScript', 'category': 'Frontend', 'desc': 'The language of the web'},
    {'id': 'bootstrap', 'title': 'Bootstrap', 'category': 'Frontend', 'desc': 'Responsive CSS Framework'},
    {'id': 'tailwindcss', 'title': 'Tailwind CSS', 'category': 'Frontend', 'desc': 'Utility-first CSS framework'},
    {'id': 'reactjs', 'title': 'React JS', 'category': 'Frontend', 'desc': 'A JavaScript library for building user interfaces'},
    {'id': 'nextjs', 'title': 'Next JS', 'category': 'Frontend', 'desc': 'The React Framework for the Web'},
    // Backend
    {'id': 'php', 'title': 'PHP', 'category': 'Backend', 'desc': 'Server-side scripting language'},
    {'id': 'nodejs', 'title': 'Node JS', 'category': 'Backend', 'desc': 'JavaScript runtime built on Chrome\'s V8 engine'},
    {'id': 'expressjs', 'title': 'Express JS', 'category': 'Backend', 'desc': 'Fast, unopinionated, minimalist web framework for Node.js'},
    // Database
    {'id': 'mysql', 'title': 'MySQL', 'category': 'Database', 'desc': 'Open-source relational database management system'},
    {'id': 'mongodb', 'title': 'MongoDB', 'category': 'Database', 'desc': 'Document-oriented NoSQL database program'},
    // Programming Languages
    {'id': 'java', 'title': 'Java', 'category': 'Programming', 'desc': 'High-level, class-based, object-oriented programming language'},
    {'id': 'python', 'title': 'Python', 'category': 'Programming', 'desc': 'High-level, general-purpose programming language'},
    {'id': 'c', 'title': 'C', 'category': 'Programming', 'desc': 'General-purpose computer programming language'},
    {'id': 'cpp', 'title': 'C++', 'category': 'Programming', 'desc': 'General-purpose programming language created as an extension of C'},
    {'id': 'csharp', 'title': 'C#', 'category': 'Programming', 'desc': 'Multi-paradigm programming language by Microsoft'},
    // CMS
    {'id': 'wordpress', 'title': 'WordPress', 'category': 'CMS', 'desc': 'Free and open-source content management system'},
    {'id': 'woocommerce', 'title': 'WooCommerce', 'category': 'CMS', 'desc': 'Open-source e-commerce plugin for WordPress'},
    {'id': 'elementor', 'title': 'Elementor', 'category': 'CMS', 'desc': 'Website builder platform for WordPress'},
    // Version Control
    {'id': 'git', 'title': 'Git', 'category': 'Version Control', 'desc': 'Distributed version control system'},
    {'id': 'github', 'title': 'GitHub', 'category': 'Version Control', 'desc': 'Internet hosting for software development and version control using Git'},
    // Design
    {'id': 'uiux', 'title': 'UI/UX Design', 'category': 'Design', 'desc': 'User Interface and User Experience Design'},
    {'id': 'figma', 'title': 'Figma', 'category': 'Design', 'desc': 'Collaborative web application for interface design'},
    // APIs
    {'id': 'restapi', 'title': 'REST API', 'category': 'APIs', 'desc': 'Representational state transfer application programming interface'},
    {'id': 'graphql', 'title': 'GraphQL', 'category': 'APIs', 'desc': 'Data query and manipulation language for APIs'}
  ];

  static final List<Map<String, dynamic>> _standardModules = [
    {
      'id': 'mod_1',
      'title': 'Beginner Concepts',
      'description': 'Introduction, Setup, and Fundamentals.',
      'topics': [
        {'id': 't_1', 'title': 'Introduction & History'},
        {'id': 't_2', 'title': 'Installation & Setup'},
        {'id': 't_3', 'title': 'Basic Syntax & Structure'},
        {'id': 't_4', 'title': 'Variables & Data Types'},
        {'id': 't_5', 'title': 'Control Flow & Loops'},
      ]
    },
    {
      'id': 'mod_2',
      'title': 'Intermediate Concepts',
      'description': 'Functions, Error Handling, and Architecture.',
      'topics': [
        {'id': 't_6', 'title': 'Functions & Methods'},
        {'id': 't_7', 'title': 'Error Handling & Debugging'},
        {'id': 't_8', 'title': 'File I/O & Data Management'},
        {'id': 't_9', 'title': 'Object-Oriented Programming'},
        {'id': 't_10', 'title': 'Best Practices & Code Style'},
      ]
    },
    {
      'id': 'mod_3',
      'title': 'Advanced Concepts',
      'description': 'Concurrency, Performance, and Frameworks.',
      'topics': [
        {'id': 't_11', 'title': 'Advanced Data Structures'},
        {'id': 't_12', 'title': 'Asynchronous Programming'},
        {'id': 't_13', 'title': 'Performance Optimization'},
        {'id': 't_14', 'title': 'Security & Vulnerabilities'},
        {'id': 't_15', 'title': 'Building a Complete Project'},
      ]
    }
  ];

  static Future<void> seedData() async {
    final firestore = FirebaseFirestore.instance;

    debugPrint("Clearing old data...");
    // Since Firebase doesn't have an easy "delete collection" from client SDK, 
    // we will just overwrite/upsert the massive structured list.
    
    debugPrint("Seeding 26 Courses...");

    for (var courseMap in _courseData) {
      final String cId = courseMap['id'];
      
      final courseRef = firestore.collection('courses').doc(cId);
      await courseRef.set(CourseModel(
        id: cId,
        title: courseMap['title'],
        description: courseMap['desc'],
        category: courseMap['category'],
        totalModules: _standardModules.length,
      ).toMap());

      int modIndex = 1;
      for (var modMap in _standardModules) {
        final String mId = modMap['id'];
        final modRef = courseRef.collection('modules').doc(mId);
        
        await modRef.set(ModuleModel(
          id: mId,
          courseId: cId,
          title: modMap['title'],
          description: modMap['description'],
          orderIndex: modIndex,
          totalTopics: (modMap['topics'] as List).length,
        ).toMap());

        int topIndex = 1;
        for (var topicMap in modMap['topics']) {
          final String tId = topicMap['id'];
          final topRef = modRef.collection('topics').doc(tId);
          
          await topRef.set(TopicModel(
            id: tId,
            moduleId: mId,
            title: topicMap['title'],
            // WE LEAVE CONTENT BLANK, APP WILL DYNAMICALLY GENERATE IT
            contentMarkdown: 'DYNAMIC_AI_CONTENT', 
            orderIndex: topIndex,
            xpReward: 20 + (modIndex * 10),
          ).toMap());
          topIndex++;
        }
        modIndex++;
      }
    }
    
    debugPrint("Finished Seeding Database with 26 Languages & Technologies!");
  }
}
