import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_news_app/pages/weather_page.dart';
import 'package:weather_news_app/providers/news_provider.dart';
import 'package:weather_news_app/providers/settings_provider.dart';
import 'package:weather_news_app/providers/weather_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ChangeNotifierProvider(create: (_) => NewsProvider()),
      ChangeNotifierProvider(create: (_) => SettingsProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WeatherScreen());
  }
}
