import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  String _temperatureUnit = 'Celsius';
  Set<String> _selectedNewsCategories = {
    'All',
    'Google News',
    'CNBC',
    'Benzinga',
    'Fox Business',
    'Bloomberg'
  };

  String get temperatureUnit => _temperatureUnit;
  Set<String> get selectedNewsCategories => _selectedNewsCategories;

  void setTemperatureUnit(String unit) {
    _temperatureUnit = unit;
    notifyListeners();
  }

  void toggleNewsCategory(String category) {
    if (category == 'All') {
      _selectedNewsCategories = {
        'All',
        'Google News',
        'CNBC',
        'Benzinga',
        'Fox Business',
        'Bloomberg'
      };
    } else {
      _selectedNewsCategories.remove('All');
      if (_selectedNewsCategories.contains(category)) {
        _selectedNewsCategories.remove(category);
      } else {
        _selectedNewsCategories.add(category);
      }
    }
    notifyListeners();
  }
}
