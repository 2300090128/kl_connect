import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news_model.dart';

class NewsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<NewsModel>> getNews() {
    return _db.collection('news').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => NewsModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }
}