import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orot/pages/profile/profile_page.dart';
import 'package:orot/pages/volunteer/home/home_page.dart';
import 'package:orot/pages/volunteer/visits_history/visits_history_page.dart';

class VolunteerNavigation extends StatefulWidget {
  const VolunteerNavigation({super.key});

  @override
  State<VolunteerNavigation> createState() => _VolunteerNavigationState();
}

class _VolunteerNavigationState extends State<VolunteerNavigation> {
  Widget _currentChild = const SizedBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentChild,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getSelectedIndex(context),
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
        ],
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).state?.uri.toString();
    if (location!.endsWith('/home')) return 0;
    if (location.endsWith('/history')) return 1;
    if (location.endsWith('/profile')) return 2;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        setState(() => _currentChild = const HomePage());
        break;
      case 1:
        context.go('/history');
        setState(() => _currentChild = const VisitsHistoryPage());
        break;
      case 2:
        context.go('/profile');
        setState(() => _currentChild = const ProfilePage());
        break;
    }
  }
}
