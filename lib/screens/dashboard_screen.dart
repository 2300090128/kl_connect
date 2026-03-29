import 'package:flutter/material.dart';
import '../widgets/news_card.dart';
import '../models/news_model.dart';
import '../main.dart' as main;
import '../widgets/app_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<Map<String, String>> newsList = [];

  void openAdmin() async {
    final result = await Navigator.pushNamed(context, '/admin');

    if (result != null) {
      setState(() {
        newsList.insert(0, result as Map<String, String>);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text("KLConnect"),
          actions: [
            /// 🔐 ONLY SHOW FOR ADMIN
            if (main.userRole == "admin")
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: openAdmin,
              )
          ],
        ),

        body: newsList.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox, size: 60, color: Colors.grey),
                    SizedBox(height: 10),
                    Text("No news available"),
                  ],
                ),
              )
            : ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final item = newsList[index];

                return NewsCard(
                  news: NewsModel(
                    id: item["id"] ?? index.toString(),
                    title: item["title"] ?? "",
                    content: item["content"] ?? "",
                    imageUrl: item["imageUrl"] ?? "",
                    summary: item["summary"] ?? "",
                  ),
                );
              },
            ),
      ),
    );
  }
}