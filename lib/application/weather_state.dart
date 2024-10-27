part of 'weather_bloc.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {
  final CoreFailure failure;
  WeatherError(this.failure);
}

class CurrentWeatherLoaded extends WeatherState {
  final CurrentWeather currentWeather;
  CurrentWeatherLoaded(this.currentWeather);
}

class WeatherForecastLoaded extends WeatherState {
  final List<SimplifiedWeatherData> weatherForecast;
  WeatherForecastLoaded(this.weatherForecast);
}

class WeatherDataLoaded extends WeatherState {
  final CurrentWeather currentWeather;
  final List<SimplifiedWeatherData> weatherForecast;
  WeatherDataLoaded(this.currentWeather, this.weatherForecast);
}
