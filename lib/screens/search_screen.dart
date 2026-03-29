import 'package:flutter/material.dart';
import '../widgets/news_card.dart';
import '../models/news_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController searchController = TextEditingController();

  bool isLoading = false;

  /// ✅ FIXED DATA STRUCTURE
  List<Map<String, String>> allNews = [
    {
      "id": "1",
      "title": "Sports Meet Announced",
      "content": "Big sports event coming soon",
      "imageUrl": "https://picsum.photos/400/200",
      "category": "Sports"
    },
    {
      "id": "2",
      "title": "Academics Seminar",
      "content": "Important academic seminar",
      "imageUrl": "https://picsum.photos/401/200",
      "category": "Academics"
    },
    {
      "id": "3",
      "title": "Department Event",
      "content": "Department level event",
      "imageUrl": "https://picsum.photos/402/200",
      "category": "Dept"
    },
  ];

  final List<String> categories = [
    "All",
    "Sports",
    "Academics",
    "Dept",
    "Year"
  ];

  String selectedCategory = "All";
  String searchQuery = "";

  /// 🔄 REFRESH (FIXED)
  Future<void> loadData() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;

      allNews = [
        {
          "id": "4",
          "title": "🔥 New Sports Update",
          "content": "Latest sports update",
          "imageUrl": "https://picsum.photos/410/200",
          "category": "Sports"
        },
        {
          "id": "5",
          "title": "🔥 Fresh Academic News",
          "content": "Latest academic news",
          "imageUrl": "https://picsum.photos/411/200",
          "category": "Academics"
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {

    final filteredNews = allNews.where((item) {
      final matchesSearch = item["title"]!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchesCategory =
          selectedCategory == "All" ||
          item["category"] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Search"),
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
              : RefreshIndicator(
                  onRefresh: loadData,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// 🔍 SEARCH BAR
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Search news...",
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),

                      /// 🔥 FILTER TITLE
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Filters",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// 🏷 FILTER CHIPS
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: ChoiceChip(
                                label: Text(category),
                                selected: selectedCategory == category,
                                selectedColor: const Color(0xFF003366),
                                labelStyle: TextStyle(
                                  color: selectedCategory == category
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                onSelected: (selected) {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// 📰 RESULTS
                      Expanded(
                        child: filteredNews.isEmpty
                            ? ListView(
                                physics:
                                    const AlwaysScrollableScrollPhysics(),
                                children: const [
                                  SizedBox(height: 100),
                                  Center(
                                    child: Column(
                                      children: [
                                        Icon(Icons.inbox,
                                            size: 60,
                                            color: Colors.grey),
                                        SizedBox(height: 10),
                                        Text("No results found"),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                physics:
                                    const AlwaysScrollableScrollPhysics(),
                                itemCount: filteredNews.length,
                                itemBuilder: (context, index) {
                                  final item = filteredNews[index];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: NewsCard(
                                      news: NewsModel(
                                        id: item["id"]!,
                                        title: item["title"]!,
                                        content: item["content"]!,
                                        imageUrl: item["imageUrl"]!,
                                        summary: "",
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}