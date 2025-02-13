
// --- Weather Events --- (Define what can happen in the weather data fetching process)
sealed class WeatherEvent {} // Abstract class, base for all weather events

final class WeatherFetched extends WeatherEvent {} // Event for fetching weather data

