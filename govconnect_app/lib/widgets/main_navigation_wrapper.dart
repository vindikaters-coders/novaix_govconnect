import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:govconnect_app/screens/user/book_officer.dart';
import 'package:govconnect_app/widgets/custom_bottom_nav_bar.dart';

import '../screens/user/user_dashboard.dart';
import '../screens/user/user_profile.dart';
import '../screens/user/user_tasks_page.dart';


class MainNavigationWrapper extends StatefulWidget {
  final int initialIndex;

  const MainNavigationWrapper({
    super.key,
    this.initialIndex = 0,
  });

  @override
  MainNavigationWrapperState createState() => MainNavigationWrapperState();
}

class MainNavigationWrapperState extends State<MainNavigationWrapper> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const UserDashboard(),
    const UserTasksPage(),
    const BookOfficerPage(),
    const ProfilePage(),
  ];

  final List<String> _routes = [
    '/dashboard',
    '/tasks',
    '/appointments',
    '/profile',
  ];

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      // Navigate to the corresponding route
      context.go(_routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class NavigationHelper {
  static int getIndexFromRoute(String route) {
    switch (route) {
      case '/dashboard':
        return 0;
      case '/tasks':
        return 1;
      case '/appointments':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }
}