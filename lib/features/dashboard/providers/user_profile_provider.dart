import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/models/user_model.dart';
import 'package:codemaster_pro/features/auth/providers/auth_repository.dart';
import 'package:codemaster_pro/features/auth/providers/user_repository.dart';

final currentUserProfileProvider = FutureProvider<UserModel?>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;
  return ref.watch(userRepositoryProvider).getUserProfile(user.uid);
});
