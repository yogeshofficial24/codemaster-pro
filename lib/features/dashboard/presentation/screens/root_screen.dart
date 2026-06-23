import 'package:flutter/material.dart';
import 'package:codemaster_pro/core/theme/app_colors.dart';
import 'package:codemaster_pro/features/learning/presentation/screens/course_list_screen.dart';
import 'package:codemaster_pro/features/ai_assistant/presentation/screens/ai_chat_screen.dart';
import 'package:codemaster_pro/features/practice/presentation/screens/practice_dashboard_screen.dart';
import 'package:codemaster_pro/features/profile/presentation/screens/profile_screen.dart';
import 'package:codemaster_pro/services/update_service.dart';
import 'dashboard_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UpdateService.checkForUpdates(context);
    });
  }

  final List<Widget> _screens = [
    const DashboardScreen(),
    const CourseListScreen(),
    const AIChatScreen(),
    const PracticeDashboardScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.book_outlined), selectedIcon: Icon(Icons.book), label: 'Learn'),
          NavigationDestination(icon: Icon(Icons.smart_toy_outlined), selectedIcon: Icon(Icons.smart_toy), label: 'AI Coach'),
          NavigationDestination(icon: Icon(Icons.code_outlined), selectedIcon: Icon(Icons.code), label: 'Practice'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
