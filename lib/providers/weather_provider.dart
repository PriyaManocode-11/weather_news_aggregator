import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_news_app/constants.dart/constant_params.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherFactory _weatherFactory =
      WeatherFactory(ConstantParams.openWeatherApiKey);
  Weather? _weather;
  List<Weather>? _forecast;
  bool isCelsius = true;

  Weather? get weather => _weather;
  List<Weather>? get forecast => _forecast;

  Future<void> fetchWeather(String cityName) async {
    _weather = await _weatherFactory.currentWeatherByCityName(cityName);
    notifyListeners();
  }

  Future<void> fetchFiveDayForecast(String cityName) async {
    _forecast = await _weatherFactory.fiveDayForecastByCityName(cityName);
    notifyListeners();
  }
}
