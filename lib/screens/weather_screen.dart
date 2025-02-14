import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/weather_bloc.dart';
import '../events/weather_event.dart';
import '../states/weather_state.dart';
import '../widgets/additional_info_item.dart';

// --- Weather Screen ---
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<WeatherBloc>()
        .add(WeatherFetched()); // Fetch weather data on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<WeatherBloc>()
                  .add(WeatherFetched()); // Refresh weather data
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        // Rebuilds UI based on WeatherState
        builder: (context, state) {
          if (state is WeatherFailure) {
            // Display error message on failure
            return Center(
              child: Text(state.error),
            );
          }

          if (state is WeatherLoading) {
            // Display loading indicator while loading
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is WeatherInitial) {
            //Handle initial state if needed. In this case, it's covered by loading.
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is! WeatherSuccess) {
            // Should not happen but good to have a catch-all
            return const Center(
              child: Text("Unexpected State"),
            );
          }

          // Access weather data when in WeatherSuccess state
          final data = state.weatherModel;

          final currentTemp = data.currentTemp;
          final currentSky = data.currentSky;
          final currentPressure = data.currentPressure;
          final currentWindSpeed = data.currentWindSpeed;
          final currentHumidity = data.currentHumidity;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Card (Displays current weather information)
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        // Apply blur effect
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K', // Display current temperature
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons
                                        .cloud // Display appropriate icon based on weather
                                    : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                currentSky, // Display current sky condition
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Additional Information', // Section title
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

