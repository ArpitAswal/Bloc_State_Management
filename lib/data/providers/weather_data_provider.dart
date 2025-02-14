import 'package:http/http.dart' as http;

import '../../secrets.dart';

// --- Weather Data Provider --- (Handles fetching weather data from the API)
class WeatherDataProvider {

  Future<String> getCurrentWeather(String cityName) async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey&units=metric', // Added units=metric
        ),
      );

      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}