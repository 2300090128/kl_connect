import 'package:flutter/material.dart';

class ClubsScreen extends StatefulWidget {
  const ClubsScreen({super.key});

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {

  bool isClubs = true;

  // 🔹 Dummy Data
  final List<Map<String, String>> clubs = [
    {
      "title": "Coding Club",
      "image": "https://picsum.photos/200/200?1"
    },
    {
      "title": "Music Club",
      "image": "https://picsum.photos/200/200?2"
    },
    {
      "title": "Dance Club",
      "image": "https://picsum.photos/200/200?3"
    },
  ];

  final List<Map<String, String>> activities = [
    {
      "title": "Hackathon",
      "image": "https://picsum.photos/200/200?4"
    },
    {
      "title": "Workshop",
      "image": "https://picsum.photos/200/200?5"
    },
    {
      "title": "Seminar",
      "image": "https://picsum.photos/200/200?6"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final data = isClubs ? clubs : activities;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Clubs & Activities"),
      ),

      body: Column(
        children: [

          /// 🔄 TOGGLE BUTTONS
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                _buildToggleButton("Clubs", isClubs),
                const SizedBox(width: 12),
                _buildToggleButton("Activities", !isClubs),
              ],
            ),
          ),

          /// 🔲 GRID VIEW
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Column(
                    children: [

                      /// IMAGE
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          item["image"]!,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// TITLE
                      Text(
                        item["title"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Toggle Button Widget
  Widget _buildToggleButton(String text, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClubs = text == "Clubs";
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF003366) : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}