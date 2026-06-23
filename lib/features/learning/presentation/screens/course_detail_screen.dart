import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';
import 'package:codemaster_pro/models/course_model.dart';
import 'package:codemaster_pro/features/learning/providers/course_repository.dart';
import 'package:codemaster_pro/features/learning/providers/progress_repository.dart';
import 'topic_reader_screen.dart';

class CourseDetailScreen extends ConsumerStatefulWidget {
  final CourseModel course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  ConsumerState<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends ConsumerState<CourseDetailScreen> {
  int _completedCount = 0;
  Map<String, bool> _completedModules = {};

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final repo = ref.read(progressRepositoryProvider);
    final count = await repo.getCompletedModulesCount(widget.course.id);
    
    // We fetch all module IDs to check their status. To do this perfectly offline,
    // we just rebuild state. The topic list builds lazily, so we'll check it per module in build.
    setState(() {
      _completedCount = count;
    });
  }

  Future<bool> _checkModuleStatus(String moduleId) async {
    if (_completedModules.containsKey(moduleId)) {
      return _completedModules[moduleId]!;
    }
    final isCompleted = await ref.read(progressRepositoryProvider).isModuleCompleted(widget.course.id, moduleId);
    _completedModules[moduleId] = isCompleted;
    return isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    final modulesAsync = ref.watch(modulesProvider(widget.course.id));
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      body: Column(
        children: [
          // Progress Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.grey[100],
              border: Border(bottom: BorderSide(color: isDark ? Colors.white12 : Colors.black12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Course Progress', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onSurface)),
                    Text('$_completedCount / ${widget.course.totalModules} Modules', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: widget.course.totalModules > 0 ? _completedCount / widget.course.totalModules : 0,
                  backgroundColor: isDark ? Colors.white12 : Colors.grey[300],
                  color: AppColors.success,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: modulesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: colorScheme.onSurface))),
              data: (modules) {
                if (modules.isEmpty) {
                  return Center(child: Text('No modules added yet.', style: TextStyle(color: colorScheme.onSurface)));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: modules.length,
                  itemBuilder: (context, index) {
                    final module = modules[index];
                    final topicsAsync = ref.watch(topicsProvider('${widget.course.id}::${module.id}'));
                    
                    return Card(
                      color: colorScheme.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ExpansionTile(
                        title: Text(module.title, style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
                        subtitle: Text(module.description, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
                        iconColor: colorScheme.primary,
                        collapsedIconColor: colorScheme.onSurface,
                        children: topicsAsync.when(
                          loading: () => [const Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator())],
                          error: (e, s) => [Padding(padding: const EdgeInsets.all(16.0), child: Text('Error: $e', style: TextStyle(color: colorScheme.onSurface)))],
                          data: (topics) {
                            if (topics.isEmpty) {
                              return [Padding(padding: const EdgeInsets.all(16.0), child: Text('No topics yet.', style: TextStyle(color: colorScheme.onSurface)))];
                            }
                            return topics.map((topic) {
                              return FutureBuilder<bool>(
                                future: _checkModuleStatus(topic.moduleId),
                                builder: (context, snapshot) {
                                  final isDone = snapshot.data ?? false;
                                  return ListTile(
                                    leading: Icon(
                                      isDone ? Icons.check_circle : Icons.play_circle_outline,
                                      color: isDone ? AppColors.success : AppColors.primary,
                                    ),
                                    title: Text(
                                      topic.title,
                                      style: TextStyle(
                                        decoration: isDone ? TextDecoration.lineThrough : null,
                                        color: isDone ? Colors.grey : colorScheme.onSurface,
                                      ),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: colorScheme.onSurface.withOpacity(0.5)),
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => TopicReaderScreen(
                                            topic: topic,
                                            courseId: widget.course.id,
                                          ),
                                        ),
                                      );
                                      // Refresh progress when returning
                                      _completedModules.clear();
                                      _loadProgress();
                                    },
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
          ),
        ],
      ),
    );
  }
}
