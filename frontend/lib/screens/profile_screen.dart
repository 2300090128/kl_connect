import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [

                const CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xFF003366),
                  child: Icon(Icons.person, size: 55, color: Colors.white),
                ),

                const SizedBox(height: 16),

                Text(
                  "John Doe",
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 6),

                const Text(
                  "john@example.com",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 24),

                _buildOption(
                  icon: Icons.edit,
                  text: "Edit Profile",
                  onTap: () {
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                ),

                const SizedBox(height: 12),

                _buildOption(
                  icon: Icons.dark_mode,
                  text: "Dark Mode (Coming Soon)",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Dark mode coming soon")),
                    );
                  },
                ),

                const SizedBox(height: 12),

                _buildOption(
                  icon: Icons.settings,
                  text: "Settings",
                  onTap: () {},
                ),

                const SizedBox(height: 12),

                _buildOption(
                  icon: Icons.auto_awesome,
                  text: "🤖 AI Chat Assistant",
                  onTap: () {
                    Navigator.pushNamed(context, '/ai-chat');
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Logout"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF003366)),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}