// lib/main.dart

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController _cityController = TextEditingController();

  Future<void> _getWeatherData(String city) async {
    final apiKey = 'f26922e5c3748d3edfb25e7de432e1c5';
    final currentWeatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';
    final forecastUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey';

    final currentWeatherResponse = await http.get(Uri.parse(currentWeatherUrl));
    final forecastResponse = await http.get(Uri.parse(forecastUrl));

    if (currentWeatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      final Map<String, dynamic> currentWeatherData =
          json.decode(currentWeatherResponse.body);
      final Map<String, dynamic> forecastData =
          json.decode(forecastResponse.body);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherDetailScreen(
            cityName: currentWeatherData['name'],
            temperature: currentWeatherData['main']['temp'],
            description: currentWeatherData['weather'][0]['description'],
            humidity: currentWeatherData['main']['humidity'],
            windSpeed: currentWeatherData['wind']['speed'],
            forecastData: forecastData['list'],
          ),
        ),
      );
    } else {
      setState(() {
        _weatherData = 'Error fetching weather data';
      });
    }
  }

  String _weatherData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather World',
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          elevation: 10, // Add elevation to the app bar
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'images/imgme.jpg'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'Enter city'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _getWeatherData(_cityController.text);
                  },
                  child: Text('Get Weather'),
                ),
                SizedBox(height: 20),
                Text(_weatherData),
              ],
            ),
          ),
        ));
  }
}
