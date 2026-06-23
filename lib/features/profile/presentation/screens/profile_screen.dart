import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';
import 'package:codemaster_pro/core/widgets/glassmorphism_card.dart';
import 'package:codemaster_pro/features/dashboard/providers/user_profile_provider.dart';
import 'settings_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(currentUserProfileProvider);

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Portfolio'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          )
        ],
      ),
      body: userProfileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (user) {
          if (user == null) {
            return const Center(child: Text('User profile not found.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Portfolio Header
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(60),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: colorScheme.surface,
                          backgroundImage: user.profilePicture.isNotEmpty ? NetworkImage(user.profilePicture) : null,
                          child: user.profilePicture.isEmpty ? const Icon(Icons.person, size: 60, color: AppColors.primary) : null,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check, size: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  user.fullName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.targetJobRole.isEmpty ? 'Software Engineer' : user.targetJobRole,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: isDark ? AppColors.textSecondaryDark : Colors.grey[700], fontSize: 14),
                ),
                
                const SizedBox(height: 40),
                
                // Professional Stats
                Row(
                  children: [
                    Expanded(child: _buildPortfolioStat(context, 'Experience', 'Junior')),
                    Container(width: 1, height: 40, color: isDark ? Colors.white24 : Colors.black12),
                    Expanded(child: _buildPortfolioStat(context, 'Projects', '${user.coursesCompleted * 2}')),
                    Container(width: 1, height: 40, color: isDark ? Colors.white24 : Colors.black12),
                    Expanded(child: _buildPortfolioStat(context, 'Commits', '${user.xpEarned}')),
                  ],
                ),
                
                const SizedBox(height: 40),
                const Text('Tech Stack', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildSkillChip('HTML/CSS', AppColors.accent),
                    _buildSkillChip('JavaScript', AppColors.warning),
                    _buildSkillChip('React', AppColors.secondary),
                    _buildSkillChip('Flutter', Colors.blue),
                    _buildSkillChip('UI/UX', AppColors.primary),
                  ],
                ),

                const SizedBox(height: 40),
                const Text('Certifications & Badges', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildBadgeCard(context, 'Frontend Pro', Icons.web, AppColors.secondary),
                      const SizedBox(width: 16),
                      _buildBadgeCard(context, 'Problem Solver', Icons.psychology, AppColors.accent),
                      const SizedBox(width: 16),
                      if (user.coursesCompleted > 0)
                        _buildBadgeCard(context, 'Fast Learner', Icons.flash_on, AppColors.warning),
                      const SizedBox(width: 16),
                      if (user.xpEarned > 100)
                        _buildBadgeCard(context, 'Centurion', Icons.military_tech, AppColors.primary),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
                GlassmorphismCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('Hire Me / Connect', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download),
                        label: const Text('Download Resume'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPortfolioStat(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(value, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isDark ? AppColors.textSecondaryDark : Colors.grey[700], fontSize: 13)),
      ],
    );
  }

  Widget _buildSkillChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        border: Border.all(color: color.withAlpha(80)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildBadgeCard(BuildContext context, String title, IconData icon, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
        boxShadow: isDark ? [] : [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 36),
          const SizedBox(height: 12),
          Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }
}

