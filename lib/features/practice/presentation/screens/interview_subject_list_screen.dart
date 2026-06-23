import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';
import 'package:codemaster_pro/features/learning/providers/course_repository.dart';
import 'package:codemaster_pro/features/ai_assistant/presentation/screens/ai_interview_screen.dart';

class InterviewSubjectListScreen extends ConsumerWidget {
  const InterviewSubjectListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Interview Subject'),
        backgroundColor: AppColors.backgroundDark,
      ),
      body: coursesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: \$err')),
        data: (courses) {
          if (courses.isEmpty) {
            return const Center(child: Text('Please go to Settings and Seed Database first.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withAlpha(50),
                    child: const Icon(Icons.psychology, color: AppColors.primary),
                  ),
                  title: Text(course.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text('Start a Mock Technical Interview for \${course.title}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AIInterviewScreen(topic: course.title),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
