import 'package:flutter/material.dart';
import '../data/remote/api_service.dart';
import 'package:news_app/models/article.dart';

class Articles with ChangeNotifier {
  List<Article>? articles = [];
  List<Article>? result = [];

  getHeadLines() async {
    articles = await getArticles();
    notifyListeners();
  }

  searchNews(String searchTxt) async {
    result = await searchArticles(searchTxt);
    notifyListeners();
  }
}
