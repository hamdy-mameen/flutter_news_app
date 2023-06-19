import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/article.dart';

final API_KEY = "ADD YOUR API KEY";

Future<List<Article>?> getArticles() async {
  try {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=$API_KEY");
    final response = await http.get(url);
    return _handleResponse(response);
  } catch (e) {
    print(' ${e.toString()}');
  }
}

Future<List<Article>?> searchArticles(String searchTxt) async {
  try {
    final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=$searchTxt&apiKey=$API_KEY');
    final response = await http.get(url);
    return _handleResponse(response);
  } catch (e) {
    print(' ${e.toString()}');
  }
}

List<Article>? _handleResponse(http.Response response) {
  if (response.statusCode == 200) {
    final Map<String, dynamic> body = json.decode(response.body);
    List<dynamic> data = body['articles'];
    List<Article>? articles =
        data.map((dynamic e) => Article.fromJson(e)).toList();
    return articles;
  } else {
    print('error somthing not okay ');
  }
}
