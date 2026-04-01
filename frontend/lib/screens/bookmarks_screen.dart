import 'package:flutter/material.dart';
import '../data/bookmark_data.dart';
import '../models/news_model.dart';
import '../widgets/news_card.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {

  @override
  Widget build(BuildContext context) {
    final bookmarks = BookmarkData.bookmarks;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),

          child: bookmarks.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark, size: 60, color: Colors.grey),
                    SizedBox(height: 10),
                    Text("No saved posts"),
                  ],
                )

              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: bookmarks.length,
                  itemBuilder: (context, index) {
                    final item = bookmarks[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Stack(
                        children: [

                          /// 📰 NEWS CARD
                          NewsCard(
                            news: NewsModel(
                              id: item["id"] ?? index.toString(),
                              title: item["title"] ?? "",
                              content: item["content"] ?? "",
                              imageUrl: item["imageUrl"] ?? "",
                              summary: "",
                            ),
                          ),

                          /// ❌ DELETE BUTTON
                          Positioned(
                            right: 10,
                            top: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    bookmarks.removeAt(index);
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Removed from bookmarks")),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}