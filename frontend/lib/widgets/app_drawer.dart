import 'package:flutter/material.dart';
import '../main.dart' as main;

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          /// 👤 USER PROFILE HEADER
          UserAccountsDrawerHeader(
            accountName: const Text(
              "John Doe",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: const Text(
              "john@example.com",
              style: TextStyle(color: Colors.white70),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "JD",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003366),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF003366),
              border: Border.all(color: const Color(0xFF003366)),
            ),
            onDetailsPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),

          const SizedBox(height: 12),

          /// 📱 NAVIGATION ITEMS
          _buildDrawerItem(
            context: context,
            icon: Icons.home,
            label: "Dashboard",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/dashboard');
            },
          ),

          _buildDrawerItem(
            context: context,
            icon: Icons.notifications,
            label: "Notifications",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/notifications');
            },
          ),

          _buildDrawerItem(
            context: context,
            icon: Icons.announcement,
            label: "Announcements",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/announcements');
            },
          ),

          _buildDrawerItem(
            context: context,
            icon: Icons.work,
            label: "Placements",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/placements');
            },
          ),

          _buildDrawerItem(
            context: context,
            icon: Icons.bookmark,
            label: "Bookmarks",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/bookmarks');
            },
          ),

          _buildDrawerItem(
            context: context,
            icon: Icons.person,
            label: "Profile",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),

          _buildDrawerItem(
            context: context,
            icon: Icons.auto_awesome,
            label: "AI Chat",
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/ai-chat');
            },
          ),

          const Divider(height: 24, thickness: 1),

          /// 🚪 LOGOUT
          _buildDrawerItem(
            context: context,
            icon: Icons.logout,
            label: "Logout",
            isLogout: true,
            onTap: () {
              Navigator.pop(context);
              main.userRole = "user";
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out successfully")),
              );
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  /// Helper method to build drawer items
  static Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : const Color(0xFF003366),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isLogout ? Colors.red : Colors.black87,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      hoverColor: Colors.grey[100],
    );
  }
}
