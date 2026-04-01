class NewsModel {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String summary;

  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.summary,
  });

  factory NewsModel.fromMap(Map<String, dynamic> data, String id) {
    return NewsModel(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      summary: data['summary'] ?? '',
    );
  }
}