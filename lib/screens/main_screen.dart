import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'search_screen.dart';
import 'events_screen.dart'; // ✅ ADD THIS
import 'clubs_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int selectedIndex = 0;

  /// ✅ UPDATED SCREENS (5)
  final List<Widget> screens = const [
    DashboardScreen(),
    SearchScreen(),
    EventsScreen(), // ✅ NEW
    ClubsScreen(),
    ProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,

        selectedItemColor: const Color(0xFF003366),
        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed,

        /// ✅ UPDATED ITEMS (5)
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.event), // ✅ NEW
            label: "Events",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Clubs",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}