import 'package:flutter/material.dart';
import 'announcement_detail_screen.dart'; // ✅ ADD THIS

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {

  bool isLoading = true;

  List<Map<String, String>> announcements = [];

  @override
  void initState() {
    super.initState();
    loadAnnouncements();
  }

  Future<void> loadAnnouncements() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;

      announcements = [
        {
          "title": "College Closed Tomorrow",
          "desc": "Due to heavy rain, college will remain closed.",
          "date": "Today"
        },
        {
          "title": "Mid Exams Postponed",
          "desc": "New exam dates will be announced soon.",
          "date": "Yesterday"
        },
        {
          "title": "Fee Payment Reminder",
          "desc": "Last date is March 30.",
          "date": "2 days ago"
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcements"),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),

          child: isLoading
              ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF003366),
                ),
              )

              : announcements.isEmpty
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.campaign, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text("No announcements"),
                      ],
                    )

                  : RefreshIndicator(
                      onRefresh: loadAnnouncements,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        itemCount: announcements.length,
                        itemBuilder: (context, index) {
                          final item = announcements[index];

                          /// ✅ FIX: CLICK → DETAIL SCREEN
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AnnouncementDetailScreen(
                                    title: item["title"]!,
                                    desc: item["desc"]!,
                                    date: item["date"]!,
                                  ),
                                ),
                              );
                            },

                            child: Card(
                              child: ListTile(
                                leading: const Icon(
                                  Icons.campaign,
                                  color: Color(0xFF003366),
                                ),
                                title: Text(
                                  item["title"]!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                subtitle: Text(item["desc"]!),
                                trailing: Text(
                                  item["date"]!,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
  }
}