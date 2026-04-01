import 'package:flutter/material.dart';

class PlacementsScreen extends StatefulWidget {
  const PlacementsScreen({super.key});

  @override
  State<PlacementsScreen> createState() => _PlacementsScreenState();
}

class _PlacementsScreenState extends State<PlacementsScreen> {

  bool isLoading = true;

  List<Map<String, String>> placements = [];

  @override
  void initState() {
    super.initState();
    loadPlacements();
  }

  Future<void> loadPlacements() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;

      placements = [
        {
          "company": "TCS",
          "package": "6 LPA",
          "role": "Software Engineer",
          "date": "March 20"
        },
        {
          "company": "Infosys",
          "package": "5 LPA",
          "role": "System Engineer",
          "date": "March 22"
        },
        {
          "company": "Google",
          "package": "30 LPA",
          "role": "SDE",
          "date": "April 5"
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Placements"),
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

              : placements.isEmpty
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.work, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text("No placements available"),
                      ],
                    )

                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: placements.length,
                      itemBuilder: (context, index) {
                        final item = placements[index];

                        return Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.business,
                              color: Color(0xFF003366),
                            ),
                            title: Text(
                              item["company"]!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                            subtitle: Text(
                                "${item["role"]} • ${item["package"]}"),
                            trailing: Text(
                              item["date"]!,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12),
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