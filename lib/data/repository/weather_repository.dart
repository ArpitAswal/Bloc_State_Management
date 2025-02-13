// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../model/weather_model.dart';
import '../provider/weather_data_provider.dart';

// --- Weather Repository --- (Provides an abstraction layer for data fetching)
class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'New Delhi'; // You can change the city name
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred: ${data['message']}'; // Include error message from API
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}

