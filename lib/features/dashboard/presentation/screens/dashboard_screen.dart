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
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ready to build the future?',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).brightness == Brightness.dark ? AppColors.textSecondaryDark : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          backgroundImage: user?.profilePicture.isNotEmpty == true ? NetworkImage(user!.profilePicture) : null,
                          child: user?.profilePicture.isEmpty == true ? const Icon(Icons.person, color: AppColors.secondary) : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  
                  // Premium Hero Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, Color(0xFF4A00E0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withAlpha(80),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Current Progress', style: TextStyle(color: Colors.white70, fontSize: 16)),
                        const SizedBox(height: 8),
                        const Text('Mastering UI/UX Design', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(child: _buildProgressStat('Overall', '12%')),
                            Container(width: 1, height: 40, color: Colors.white24),
                            Expanded(child: _buildProgressStat('Rank', 'Beginner')),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  _buildStatsSection(context, xp, courses),
                  const SizedBox(height: 32),
                  Text(
                    'Learning Statistics',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildLearningStats(context, courses),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context, int xp, int courses) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textSecondaryDark : Colors.grey[700];
    final valueColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      children: [
        Expanded(
          child: GlassmorphismCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.local_fire_department, color: AppColors.accent, size: 36),
                const SizedBox(height: 12),
                Text('Streak', style: TextStyle(fontWeight: FontWeight.w600, color: textColor)),
                Text('1 Days', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: valueColor)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GlassmorphismCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.star, color: AppColors.warning, size: 36),
                const SizedBox(height: 12),
                Text('XP Earned', style: TextStyle(fontWeight: FontWeight.w600, color: textColor)),
                Text('$xp', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: valueColor)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLearningStats(BuildContext context, int courses) {
    return Column(
      children: [
        _buildStatRow(context, 'Languages Started', '1', AppColors.secondary),
        const SizedBox(height: 12),
        _buildStatRow(context, 'Courses Completed', '$courses', AppColors.success),
        const SizedBox(height: 12),
        _buildStatRow(context, 'Challenges Solved', '0', AppColors.primary),
        const SizedBox(height: 12),
        _buildStatRow(context, 'Interview Readiness', '10%', AppColors.accent),
      ],
    );
  }

  Widget _buildStatRow(BuildContext context, String title, String value, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Theme.of(context).colorScheme.onSurface)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 18)),
        ],
      ),
    );
  }
}

