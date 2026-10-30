import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_dashboard_screen.dart';
import 'activities_screen.dart';
import 'gallery_screen.dart';
import 'institutional_profile_screen.dart';
import 'settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationScreen> createState() => MainNavigationScreenState();

  static MainNavigationScreenState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainNavigationScreenState>();
  }
}

class MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void switchTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeDashboardScreen(onTabChange: switchTab),
      const ActivitiesScreen(showBackButton: false),
      const GalleryScreen(showBackButton: false),
      const InstitutionalProfileScreen(showBackButton: false),
      const SettingsScreen(showBackButton: false),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: switchTab,
      ),
    );
  }
}
