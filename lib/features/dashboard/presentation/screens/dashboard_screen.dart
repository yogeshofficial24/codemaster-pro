import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';
import 'package:codemaster_pro/core/widgets/glassmorphism_card.dart';
import 'package:codemaster_pro/features/dashboard/providers/user_profile_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(currentUserProfileProvider);

    return Scaffold(
      body: SafeArea(
        child: userProfileAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (user) {
            final name = user?.fullName.isNotEmpty == true ? user!.fullName : 'Developer';
            final xp = user?.xpEarned ?? 0;
            final courses = user?.coursesCompleted ?? 0;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello $name 👋',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ready to master coding?',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.primary.withAlpha(50),
                        backgroundImage: user?.profilePicture.isNotEmpty == true ? NetworkImage(user!.profilePicture) : null,
                        child: user?.profilePicture.isEmpty == true ? const Icon(Icons.person, color: AppColors.primary) : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildStatsSection(xp, courses),
                  const SizedBox(height: 32),
                  Text(
                    'Learning Statistics',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildLearningStats(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatsSection(int xp, int courses) {
    return Row(
      children: [
        Expanded(
          child: GlassmorphismCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orange, size: 32),
                const SizedBox(height: 8),
                const Text('Streak', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('15 Days', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GlassmorphismCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 32),
                const SizedBox(height: 8),
                const Text('XP Earned', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('$xp', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLearningStats() {
    return Column(
      children: [
        _buildStatRow('Languages Started', '4', Colors.blue),
        const SizedBox(height: 12),
        _buildStatRow('Courses Completed', '8', Colors.green),
        const SizedBox(height: 12),
        _buildStatRow('Challenges Solved', '42', Colors.purple),
        const SizedBox(height: 12),
        _buildStatRow('Interview Readiness', '72%', Colors.teal),
      ],
    );
  }

  Widget _buildStatRow(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
        ],
      ),
    );
  }
}
