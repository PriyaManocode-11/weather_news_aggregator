import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:weather_news_app/constants.dart/styles.dart';
import 'package:weather_news_app/pages/news_page.dart';
import 'package:weather_news_app/pages/settings_page.dart';
import 'package:weather_news_app/providers/settings_provider.dart';
import 'package:weather_news_app/providers/weather_provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false)
        ..fetchWeather()
        ..fetchFiveDayForecast();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final Weather? weather = weatherProvider.weather;
    final List<Weather>? forecast = weatherProvider.forecast;
    DateTime weatherNow = weather?.date ?? DateTime.now();
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings,
                color: Color.fromARGB(255, 58, 102, 137)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingsScreen()));
            },
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Weather Report',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 58, 102, 137),
          ),
        ),
      ),
      body: SafeArea(
        child: (weather == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 219, 213, 213),
                                    Color.fromARGB(255, 3, 63, 112),
                                    Colors.blue,
                                  ],
                                  end: Alignment.bottomLeft,
                                  begin: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(50),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://openweathermap.org/img/wn/${weather.weatherIcon ?? ''}@2x.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            weather.areaName ?? '',
                                            style: textStyle(),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            (settingsProvider.temperatureUnit ==
                                                    'Celsius')
                                                ? '${weather.temperature?.celsius?.toStringAsFixed(0)} °C'
                                                : '${weather.temperature?.fahrenheit?.toStringAsFixed(0)} °F',
                                            style: textStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        weather.weatherDescription ?? '',
                                        style: textStyle(fontSize: 15),
                                      ),
                                      Text(
                                        DateFormat("EEEE").format(weatherNow),
                                        style: textStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              "Five Days Weather Forecast",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 58, 102, 137),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: constraints.maxHeight * 0.38,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: (forecast ?? []).length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 200, // Adjust the width as needed
                                  margin: const EdgeInsets.only(left: 30),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 219, 213, 213),
                                        Color.fromARGB(255, 176, 188, 198),
                                        Color.fromARGB(255, 189, 212, 231),
                                      ],
                                      end: Alignment.bottomLeft,
                                      begin: Alignment.topRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateFormat("EEEE").format(
                                            forecast?[index].date ??
                                                DateTime.now()),
                                        style: textStyle(),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        settingsProvider.temperatureUnit ==
                                                'Celsius'
                                            ? '${forecast?[index].temperature?.celsius?.toStringAsFixed(0)} °C'
                                            : '${forecast?[index].temperature?.celsius?.toStringAsFixed(0)} °F',
                                        style: textStyle(fontSize: 15),
                                        textAlign: TextAlign.center,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(40),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://openweathermap.org/img/wn/${forecast?[index].weatherIcon ?? ''}@2x.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        DateFormat("h:mm a").format(
                                            forecast?[index].date ??
                                                DateTime.now()),
                                        style: textStyle(fontSize: 12),
                                      ),
                                      Text(
                                        forecast?[index].weatherDescription ??
                                            '',
                                        style: textStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const NewsPage()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 16, 39, 78),
                                    Color.fromARGB(255, 176, 188, 198),
                                    Color.fromARGB(255, 96, 136, 169),
                                  ],
                                  end: Alignment.bottomLeft,
                                  begin: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Today\'s News',
                                  style: textStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
