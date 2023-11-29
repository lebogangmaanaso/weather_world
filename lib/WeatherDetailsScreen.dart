// lib/weather_detail_screen.dart

import 'package:flutter/material.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String description;

  WeatherDetailsScreen({
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('f26922e5c3748d3edfb25e7de432e1c5'),
            SizedBox(height: 10),
            Text('Temperature: $temperature°C'),
            SizedBox(height: 10),
            Text('Description: $description'),
          ],
        ),
      ),
    );
  }
}
