import 'package:flutter/material.dart';

class CampusNewsScreen extends StatefulWidget {
  const CampusNewsScreen({super.key});

  @override
  State<CampusNewsScreen> createState() => _CampusNewsScreenState();
}

class _CampusNewsScreenState extends State<CampusNewsScreen> {

  bool isLoading = true;

  List<Map<String, String>> campusNews = [];

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  Future<void> loadNews() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;

      campusNews = [
        {
          "title": "Library Timings Updated",
          "desc": "Library will now be open till 10 PM.",
          "date": "Today"
        },
        {
          "title": "Bus Routes Changed",
          "desc": "New routes added for hostel students.",
          "date": "Yesterday"
        },
        {
          "title": "Canteen Menu Updated",
          "desc": "New food items added this week.",
          "date": "2 days ago"
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Campus News"),
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

              : campusNews.isEmpty
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.newspaper, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text("No campus news"),
                      ],
                    )

                  : RefreshIndicator(
                      onRefresh: loadNews,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        itemCount: campusNews.length,
                        itemBuilder: (context, index) {
                          final item = campusNews[index];

                          return Card(
                            child: ListTile(
                              leading: const Icon(
                                Icons.school,
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
      ),
    );
  }
}