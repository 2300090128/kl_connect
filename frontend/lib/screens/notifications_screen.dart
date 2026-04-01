import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  bool isLoading = true;

  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;

      notifications = [
        {
          "title": "New Event Added",
          "desc": "Tech Fest 2026 is live now!",
          "time": "2 min ago"
        },
        {
          "title": "New Announcement",
          "desc": "College closed tomorrow",
          "time": "10 min ago"
        },
        {
          "title": "Placement Update",
          "desc": "TCS hiring started",
          "time": "1 hr ago"
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
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

              : notifications.isEmpty
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_off,
                            size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text("No notifications"),
                      ],
                    )

                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final item = notifications[index];

                        return Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.notifications,
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
                              item["time"]!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}