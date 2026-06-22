import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';
import 'package:codemaster_pro/models/user_model.dart';
import 'package:codemaster_pro/features/auth/providers/auth_repository.dart';
import 'package:codemaster_pro/features/auth/providers/user_repository.dart';
import 'package:codemaster_pro/features/dashboard/presentation/screens/root_screen.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _educationController = TextEditingController();
  String _selectedRole = 'Student';
  String _selectedExperience = 'Beginner';
  bool _isLoading = false;

  final List<String> _roles = [
    'Student',
    'Frontend Developer',
    'Backend Developer',
    'Full Stack Developer',
    'UI/UX Designer',
    'Java Developer',
    'WordPress Developer'
  ];

  final List<String> _experiences = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  void dispose() {
    _nameController.dispose();
    _educationController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final user = ref.read(authRepositoryProvider).currentUser;
      if (user != null) {
        final updatedUser = UserModel(
          uid: user.uid,
          email: user.email ?? '',
          fullName: _nameController.text.trim(),
          education: _educationController.text.trim(),
          targetJobRole: _selectedRole,
          experienceLevel: _selectedExperience,
        );

        await ref.read(userRepositoryProvider).saveUserProfile(updatedUser);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile Saved!')));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RootScreen()));
        }
      }
      
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Your Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tell us a bit about yourself!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _educationController,
                decoration: const InputDecoration(labelText: 'Education', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(labelText: 'Target Job Role', border: OutlineInputBorder()),
                items: _roles.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedRole = val);
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedExperience,
                decoration: const InputDecoration(labelText: 'Experience Level', border: OutlineInputBorder()),
                items: _experiences.map((exp) => DropdownMenuItem(value: exp, child: Text(exp))).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedExperience = val);
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Complete Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
