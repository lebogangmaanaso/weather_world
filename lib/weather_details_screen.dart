// lib/weather_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherDetailScreen extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final List<dynamic> forecastData;

  WeatherDetailScreen({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.forecastData,
  });

  String _getBackgroundImage() {
    if (temperature <= 10) {
      return 'images/imgcolld.jpg';
    } else if (temperature > 10 && temperature <= 25) {
      return 'images/imgmild.jpg';
    } else {
      return 'images/imgme.jpg';
    }
  }

  double _convertKelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  @override
  Widget build(BuildContext context) {
    String backgroundImage = _getBackgroundImage();
    double temperatureInCelsius = _convertKelvinToCelsius(temperature);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'City: $cityName',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Temperature: ${temperatureInCelsius.toStringAsFixed(2)}°C',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Description: $description',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Humidity: $humidity%',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Wind Speed: $windSpeed m/s',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildWeatherListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: forecastData.map((forecast) {
          final DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
          final String dayOfWeek = DateFormat('EEEE').format(dateTime);
          final String time = DateFormat.jm().format(dateTime); // Format time

          return Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    dayOfWeek,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Time: $time',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Temperature: ${_convertKelvinToCelsius(forecast['main']['temp']).toStringAsFixed(2)}°C',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: ${forecast['weather'][0]['description']}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
