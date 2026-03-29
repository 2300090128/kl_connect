import 'package:flutter/material.dart';

class AcademicsScreen extends StatelessWidget {
  const AcademicsScreen({super.key});

  final List<Map<String, String>> academics = const [
    {
      "title": "Timetable",
      "subtitle": "View your class schedule",
      "icon": "schedule"
    },
    {
      "title": "Syllabus",
      "subtitle": "Course subjects & topics",
      "icon": "book"
    },
    {
      "title": "Exam Schedule",
      "subtitle": "Upcoming exams",
      "icon": "event"
    },
    {
      "title": "Results",
      "subtitle": "Check your results",
      "icon": "assessment"
    },
  ];

  IconData getIcon(String name) {
    switch (name) {
      case "schedule":
        return Icons.schedule;
      case "book":
        return Icons.menu_book;
      case "event":
        return Icons.event;
      case "assessment":
        return Icons.assessment;
      default:
        return Icons.school;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Academics"),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),

          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: academics.length,
            itemBuilder: (context, index) {
              final item = academics[index];

              return Card(
                child: ListTile(
                  leading: Icon(
                    getIcon(item["icon"]!),
                    color: const Color(0xFF003366),
                  ),
                  title: Text(item["title"]!),
                  subtitle: Text(item["subtitle"]!),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item["title"]} clicked")),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}