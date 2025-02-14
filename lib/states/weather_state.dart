
import '../models/weather_model.dart';

// --- Weather States --- (Define the possible states of the weather data fetching process)
sealed class WeatherState {} // Abstract class, base for all weather states

final class WeatherInitial extends WeatherState {} // Initial state, no weather data yet

final class WeatherLoading extends WeatherState {} // Loading state, during data fetching

final class WeatherSuccess extends WeatherState { // Success state, weather data fetched
  final WeatherModel weatherModel;

  WeatherSuccess({required this.weatherModel});
}

final class WeatherFailure extends WeatherState { // Failure state, data fetching failed
  final String error;

  WeatherFailure(this.error);
}
