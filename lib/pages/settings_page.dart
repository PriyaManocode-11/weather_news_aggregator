import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_news_app/providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Temperature Unit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('Celsius'),
            value: 'Celsius',
            groupValue: settingsProvider.temperatureUnit,
            onChanged: (value) {
              settingsProvider.setTemperatureUnit(value!);
            },
          ),
          RadioListTile<String>(
            title: const Text('Fahrenheit'),
            value: 'Fahrenheit',
            groupValue: settingsProvider.temperatureUnit,
            onChanged: (value) {
              settingsProvider.setTemperatureUnit(value!);
            },
          ),
          const SizedBox(height: 10),
          const Text(
            'News Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: [
                CheckboxListTile(
                  title: const Text('All'),
                  value:
                      settingsProvider.selectedNewsCategories.contains('All'),
                  onChanged: (value) {
                    settingsProvider.toggleNewsCategory('All');
                  },
                ),
                CheckboxListTile(
                  title: const Text('Google News'),
                  value: settingsProvider.selectedNewsCategories
                      .contains('Google News'),
                  onChanged: (value) {
                    settingsProvider.toggleNewsCategory('Google News');
                  },
                ),
                CheckboxListTile(
                  title: const Text('CNBC'),
                  value:
                      settingsProvider.selectedNewsCategories.contains('CNBC'),
                  onChanged: (value) {
                    settingsProvider.toggleNewsCategory('CNBC');
                  },
                ),
                CheckboxListTile(
                  title: const Text('Benzinga'),
                  value: settingsProvider.selectedNewsCategories
                      .contains('Benzinga'),
                  onChanged: (value) {
                    settingsProvider.toggleNewsCategory('Benzinga');
                  },
                ),
                CheckboxListTile(
                  title: const Text('Fox Business'),
                  value: settingsProvider.selectedNewsCategories
                      .contains('Fox Business'),
                  onChanged: (value) {
                    settingsProvider.toggleNewsCategory('Fox Business');
                  },
                ),
                CheckboxListTile(
                  title: const Text('Bloomberg'),
                  value: settingsProvider.selectedNewsCategories
                      .contains('Bloomberg'),
                  onChanged: (value) {
                    settingsProvider.toggleNewsCategory('Bloomberg');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
