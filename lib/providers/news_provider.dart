import 'package:flutter/material.dart';
import '../models/news_model.dart';

class NewsProvider extends ChangeNotifier {
  List<NewsModel> _news = [];

  List<NewsModel> get news => _news;

  void setNews(List<NewsModel> newsList) {
    _news = newsList;
    notifyListeners();
  }
}