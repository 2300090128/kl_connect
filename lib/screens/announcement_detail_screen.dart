import 'package:flutter/material.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final String title;
  final String desc;
  final String date;

  const AnnouncementDetailScreen({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Announcement")),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 8),

            Text(
              date,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 16),

            Text(desc),

            const Spacer(),

            /// 🔥 ACTIONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),

                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}