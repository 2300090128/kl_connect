import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  final List<Map<String, String>> events = const [
    {
      "title": "Tech Fest 2026",
      "image": "https://picsum.photos/400/200",
      "date": "March 25"
    },
    {
      "title": "Cultural Fest",
      "image": "https://picsum.photos/401/200",
      "date": "April 10"
    },
    {
      "title": "Workshop on AI",
      "image": "https://picsum.photos/402/200",
      "date": "March 18"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),

          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final item = events[index];

              /// ✅ FIXED: GestureDetector WRAPPING CARD
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventDetailScreen(
                        title: item["title"]!,
                        image: item["image"]!,
                        date: item["date"]!,
                      ),
                    ),
                  );
                },

                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(item["image"]!),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          item["title"]!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          item["date"]!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
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