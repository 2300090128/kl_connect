/// Central data source for the entire app
class AppData {
  /// Shared news list used across Dashboard, Search, and other screens
  static List<Map<String, String>> newsList = [
    {
      "id": "1",
      "title": "Flutter 3.0 Released",
      "content": "Flutter 3.0 is now available with new features",
      "imageUrl": "https://picsum.photos/400/200?1",
      "summary": "New Flutter release with improvements",
    },
    {
      "id": "2",
      "title": "Dart Updates",
      "content": "Learn about the latest Dart language features",
      "imageUrl": "https://picsum.photos/400/200?2",
      "summary": "Dart language updates",
    },
  ];

  /// Shared bookmarks across screens
  static List<Map<String, String>> bookmarks = [];

  /// Add bookmark with duplicate check
  static void addBookmark(Map<String, String> news) {
    if (!bookmarks.any((e) => e["id"] == news["id"])) {
      bookmarks.add(news);
    }
  }

  /// Remove bookmark
  static void removeBookmark(String newsId) {
    bookmarks.removeWhere((e) => e["id"] == newsId);
  }

  /// Check if news is bookmarked
  static bool isBookmarked(String newsId) {
    return bookmarks.any((e) => e["id"] == newsId);
  }
}
