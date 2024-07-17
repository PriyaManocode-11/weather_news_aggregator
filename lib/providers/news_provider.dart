import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_news_app/constants.dart/constant_params.dart';
class NewsProvider with ChangeNotifier {
  List<dynamic> _news = [];
  List<dynamic> _filteredNews = [];
  bool _loading = false;

  List<dynamic> get news => _filteredNews;
  bool get loading => _loading;

  NewsProvider() {
    fetchNews({'All'});
  }

  Future<void> fetchNews(Set<String> selectedCategories) async {
    _loading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${ConstantParams.newsApiKey}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _news = data['articles'];

      filterNews(selectedCategories);
    } else {
      throw Exception('Failed to load news');
    }

    _loading = false;
    notifyListeners();
  }

  void filterNews(Set<String> selectedCategories) {
    if (selectedCategories.contains('All')) {
      _filteredNews = _news;
    } else {
      _filteredNews = _news.where((article) {
        final sourceName = article['source']['name'];
        return selectedCategories.contains(sourceName);
      }).toList();
    }
    notifyListeners();
  }

  void filterNewsBasedOnWeather(String weatherCondition) {
    _loading = true;
    notifyListeners();

    switch (weatherCondition) {
      case 'cold':
        _filteredNews = _news
            .where((article) =>
                article['title'].toString().contains('depressing') ||
                article['title'].toString().contains('sad') ||
                article['title'].toString().contains('gloomy'))
            .toList();
        break;
      case 'hot':
        _filteredNews = _news
            .where((article) =>
                article['title'].toString().contains('fear') ||
                article['title'].toString().contains('scary'))
            .toList();
        break;
      case 'cool':
        _filteredNews = _news
            .where((article) =>
                article['title'].toString().contains('winning') ||
                article['title'].toString().contains('happiness') ||
                article['title'].toString().contains('joyful'))
            .toList();
        break;
      default:
        _filteredNews = _news;
    }

    _loading = false;
    notifyListeners();
  }
}
