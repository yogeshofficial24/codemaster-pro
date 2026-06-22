import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/features/auth/providers/auth_repository.dart';
import 'package:codemaster_pro/features/auth/presentation/screens/login_screen.dart';
import 'package:codemaster_pro/features/auth/presentation/screens/profile_setup_screen.dart';
import 'package:codemaster_pro/features/dashboard/presentation/screens/root_screen.dart';
import 'package:codemaster_pro/features/dashboard/providers/user_profile_provider.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          final profileAsync = ref.watch(currentUserProfileProvider);
          return profileAsync.when(
            data: (profile) {
              if (profile == null || profile.fullName.isEmpty) {
                return const ProfileSetupScreen();
              }
              return const RootScreen();
            },
            loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
            error: (e, stack) => Scaffold(body: Center(child: Text('Error: $e'))),
          );
        }
        return const LoginScreen();
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, trace) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}
