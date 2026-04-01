import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String date;

  const EventDetailScreen({
    super.key,
    required this.title,
    required this.image,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Event Details")),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image.network(image),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                date,
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 12),

            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "This is full event description. You can add venue, timing, speakers etc.",
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 ACTIONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registered Successfully")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003366),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Register"),
                ),

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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}