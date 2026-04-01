import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkService {
  Future<void> toggleBookmark(String uid, String newsId) async {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('bookmarks')
        .doc(newsId);

    final doc = await ref.get();

    if (doc.exists) {
      await ref.delete();
    } else {
      await ref.set({'savedAt': Timestamp.now()});
    }
  }
}