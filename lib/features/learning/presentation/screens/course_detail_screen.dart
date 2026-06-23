import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';
import 'package:codemaster_pro/models/course_model.dart';
import 'package:codemaster_pro/features/learning/providers/course_repository.dart';
import 'topic_reader_screen.dart';

class CourseDetailScreen extends ConsumerWidget {
  final CourseModel course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modulesAsync = ref.watch(modulesProvider(course.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: modulesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (modules) {
          if (modules.isEmpty) {
            return const Center(child: Text('No modules added yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final module = modules[index];
              
              // Watch topics for this module to display them
              final topicsAsync = ref.watch(topicsProvider('\${course.id}::\${module.id}'));
              
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: Text(module.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(module.description),
                  children: topicsAsync.when(
                    loading: () => [const Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator())],
                    error: (e, s) => [Padding(padding: const EdgeInsets.all(16.0), child: Text('Error: $e'))],
                    data: (topics) {
                      if (topics.isEmpty) {
                        return [const Padding(padding: EdgeInsets.all(16.0), child: Text('No topics yet.'))];
                      }
                      return topics.map((topic) {
                        return ListTile(
                          leading: const Icon(Icons.play_circle_outline, color: AppColors.primary),
                          title: Text(topic.title),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TopicReaderScreen(topic: topic),
                              ),
                            );
                          },
                        );
                      }).toList();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
