import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:klconnect/screens/splash_screen.dart';
import 'package:klconnect/screens/login_screen.dart';
import 'package:klconnect/screens/register_screen.dart';
import 'package:klconnect/screens/forgot_password_screen.dart';
import 'package:klconnect/screens/search_screen.dart';
import 'package:klconnect/screens/clubs_screen.dart';
import 'package:klconnect/screens/profile_screen.dart';
import 'package:klconnect/screens/main_screen.dart';
import 'package:klconnect/screens/admin_post_screen.dart';
import 'package:klconnect/screens/admin_dashboard_screen.dart';
import 'package:klconnect/screens/notifications_screen.dart';
import 'package:klconnect/screens/bookmarks_screen.dart';
import 'package:klconnect/screens/announcements_screen.dart';
import 'package:klconnect/screens/edit_profile_screen.dart';
import 'package:klconnect/screens/placements_screen.dart';
import 'package:klconnect/screens/campus_news_screen.dart';
import 'package:klconnect/screens/ai_chat_screen.dart';

import 'package:klconnect/providers/news_provider.dart';
import 'package:klconnect/core/app_theme.dart';

/// 🔥 Global user role variable
String userRole = "user";

void main() {
  runApp(const KLConnectApp());
}

class KLConnectApp extends StatefulWidget {
  const KLConnectApp({super.key});

  @override
  State<KLConnectApp> createState() => _KLConnectAppState();
}

class _KLConnectAppState extends State<KLConnectApp> {

  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],

      child: MaterialApp(
        title: 'KLConnect',
        debugShowCheckedModeBanner: false,

        theme: AppTheme.lightTheme,

        initialRoute: '/',

        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/forgot': (context) => const ForgotPasswordScreen(),
          '/dashboard': (context) => const MainScreen(),
          '/search': (context) => const SearchScreen(),
          '/clubs': (context) => const ClubsScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/admin': (context) => const AdminDashboardScreen(),
          '/admin-create': (context) => const AdminPostScreen(),
          '/admin-edit': (context) {
            final post = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
            return AdminPostScreen(postData: post);
          },
          '/notifications': (context) => const NotificationsScreen(),
          '/bookmarks': (context) => const BookmarksScreen(),
          '/announcements': (context) => const AnnouncementsScreen(),
          '/edit-profile': (context) => const EditProfileScreen(),
          '/placements': (context) => const PlacementsScreen(),
          '/campus-news': (context) => const CampusNewsScreen(),
          '/ai-chat': (context) => const AIChatScreen(),
        },
      ),
    );
  }
}