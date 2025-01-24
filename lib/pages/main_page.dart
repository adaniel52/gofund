import 'package:flutter/material.dart';
import 'package:gofund/pages/donate_page.dart';
import 'package:gofund/pages/home_page.dart';
import 'package:gofund/pages/projects_page.dart';
import 'package:gofund/pages/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    DonatePage(),
    ProjectsPage(),
    SettingsPage(),
  ];

  final List<NavigationDestination> _destionations = [
    const NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    const NavigationDestination(
      icon: Icon(Icons.how_to_vote_outlined),
      selectedIcon: Icon(Icons.how_to_vote),
      label: 'Donate',
    ),
    const NavigationDestination(
      icon: Icon(Icons.work_outline),
      selectedIcon: Icon(Icons.work),
      label: 'Projects',
    ),
    const NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void _onDestinationSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: _destionations,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
