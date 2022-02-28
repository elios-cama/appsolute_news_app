import 'dart:convert';

import 'package:appsolute_news_app/models/article.dart';
import 'package:http/http.dart' as http;

Future<List<Article>> getNews() async {
 const API_KEY = String.fromEnvironment('API_KEY');
  Uri uri = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=$API_KEY");

  final response = await http.get(uri);

  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> map = json.decode(response.body);

    List _articlesList = map['articles'];

    List<Article> newsList =
        _articlesList.map((jsonData) => Article.fromJson(jsonData)).toList();
    return newsList;
  } else {
    print("error");
    return [];
  }
}
