import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/models/user_model.dart';
import 'package:codemaster_pro/features/auth/providers/auth_repository.dart';
import 'package:codemaster_pro/features/auth/providers/user_repository.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(() {
  return AuthController();
});

class AuthController extends AsyncNotifier<void> {
  late AuthRepository _authRepository;
  late UserRepository _userRepository;

  @override
  Future<void> build() async {
    _authRepository = ref.watch(authRepositoryProvider);
    _userRepository = ref.watch(userRepositoryProvider);
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _authRepository.signInWithEmail(email, password);
    });
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      UserCredential cred = await _authRepository.signUpWithEmail(email, password);
      if (cred.user != null) {
        final newUser = UserModel(uid: cred.user!.uid, email: cred.user!.email ?? email);
        await _userRepository.saveUserProfile(newUser);
      }
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      UserCredential? cred = await _authRepository.signInWithGoogle();
      if (cred != null && cred.user != null) {
        final existingUser = await _userRepository.getUserProfile(cred.user!.uid);
        if (existingUser == null) {
          final newUser = UserModel(
            uid: cred.user!.uid,
            email: cred.user!.email ?? '',
            fullName: cred.user!.displayName ?? '',
            profilePicture: cred.user!.photoURL ?? '',
          );
          await _userRepository.saveUserProfile(newUser);
        }
      }
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _authRepository.signOut();
    });
  }
}
