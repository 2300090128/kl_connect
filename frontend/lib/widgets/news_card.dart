import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../data/bookmark_data.dart';
import '../services/ai_service.dart';

class NewsCard extends StatefulWidget {
  final NewsModel news;

  const NewsCard({
    super.key,
    required this.news,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {

  bool isLiked = false;
  bool isBookmarked = false;
  bool _isLoadingSummary = false;

  /// 🤖 GENERATE AI SUMMARY
  void _generateAISummary() async {
    setState(() {
      _isLoadingSummary = true;
    });

    try {
      final aiService = AIService();
      final summary = await aiService.summarizeNews(widget.news.content);

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("✨ AI Summary"),
          content: SingleChildScrollView(
            child: Text(summary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoadingSummary = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final news = widget.news;

    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🖼 IMAGE
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              news.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          /// 📄 CONTENT
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 📰 TITLE
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                /// 📄 CONTENT
                Text(
                  news.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 10),

                /// 🔥 ACTIONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// ❤️ LIKE
                    IconButton(
                      icon: Icon(
                        isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isLiked ? "❤️ Liked!" : "Unlike"),
                            duration: const Duration(milliseconds: 800),
                          ),
                        );
                      },
                    ),

                    /// 🤖 AI SUMMARY
                    _isLoadingSummary
                        ? const SizedBox(
                            width: 48,
                            height: 48,
                            child: Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFF003366),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : IconButton(
                            icon: const Icon(Icons.auto_awesome),
                            color: Colors.amber,
                            onPressed: _generateAISummary,
                            tooltip: "AI Summary",
                          ),

                    /// 🔖 BOOKMARK
                    IconButton(
                      icon: Icon(
                        isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: isBookmarked ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });

                        if (isBookmarked) {
                          // Check for duplicates
                          if (!BookmarkData.bookmarks.any((e) => e["id"] == news.id)) {
                            BookmarkData.bookmarks.add({
                              "id": news.id,
                              "title": news.title,
                              "content": news.content,
                              "imageUrl": news.imageUrl,
                            });
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("🔖 Saved to bookmarks!"),
                              duration: Duration(milliseconds: 800),
                            ),
                          );
                        } else {
                          BookmarkData.bookmarks.removeWhere((e) => e["id"] == news.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Removed from bookmarks"),
                              duration: Duration(milliseconds: 800),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}