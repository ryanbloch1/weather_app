import 'package:fpdart/fpdart.dart';
import 'package:weather_app/domain/models/api_responses/current_weather.dart';
import 'package:weather_app/domain/models/api_responses/weather_forcast.dart';
import 'package:weather_app/domain/models/core_failures/abstract_core_failure.dart';

abstract class IWeatherRepository {
  Future<Either<CoreFailure, CurrentWeather>> getCurrentWeather();
  Future<Either<CoreFailure, WeatherForecast>> getWeatherForecast();
}
