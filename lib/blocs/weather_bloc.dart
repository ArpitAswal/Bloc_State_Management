import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/weather_repository.dart';
import '../events/weather_event.dart';
import '../states/weather_state.dart';

// --- Weather Bloc --- (Handles the weather data fetching logic and state transitions)
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetched>(_getCurrentWeather); // Register handler for WeatherFetched events
  }

  Future<void> _getCurrentWeather(
      WeatherFetched event,
      Emitter<WeatherState> emit,
      ) async {
    emit(WeatherLoading()); // Emit loading state

    try {
      final weather = await weatherRepository.getCurrentWeather();
      emit(WeatherSuccess(weatherModel: weather)); // Emit success state with weather data
    } catch (e) {
      emit(WeatherFailure(e.toString())); // Emit failure state with error message
    }
  }
}
