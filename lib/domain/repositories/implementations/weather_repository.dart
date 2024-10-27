import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/domain/models/api_responses/current_weather.dart';
import 'package:weather_app/domain/models/api_responses/weather_forcast.dart';
import 'package:weather_app/domain/models/core_failures/abstract_core_failure.dart';
import 'package:weather_app/domain/models/core_failures/api_failure.dart';
import 'package:weather_app/domain/repositories/interfaces/i_weather_repository.dart';
import 'package:fpdart/fpdart.dart';

@LazySingleton(as: IWeatherRepository)
class WeatherRepository implements IWeatherRepository {
  final Dio _dio;

  WeatherRepository(this._dio);

  @override
  Future<Either<CoreFailure, CurrentWeather>> getCurrentWeather() async {
    try {
      //get the lat long from the location service
      // final location = await locationService.getCurrentLocation();
      // final lat = location.latitude;
      // final lon = location.longitude;

      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'lat': 34.0725,
          'lon': 18.4319,
          'appid': 'a9039a87973495f01995ad4a1b22d541'
        },
      );

      return Right(CurrentWeather.fromJson(response.data));
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioError(e));
    } on Exception catch (e) {
      return Left(
          ApiFailure.general(message: 'Failed to load weather data: $e'));
    }
  }

  @override
  Future<Either<CoreFailure, WeatherForecast>> getWeatherForecast() async {
    try {
      // Assuming location fetching is similar to getCurrentWeather method
      // final location = await locationService.getCurrentLocation();
      // final lat = location.latitude;
      // final lon = location.longitude;
      // final cnt = 7; // Number of days for forecast

      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/forecast',
        queryParameters: {
          'lat': 34.0725, // Replace with actual latitude
          'lon': 18.4319, // Replace with actual longitude
          'cnt': 30, // Number of days for forecast
          'appid': 'a9039a87973495f01995ad4a1b22d541' // Your actual API key
        },
      );

      return Right(WeatherForecast.fromJson(response.data));
    } on Exception catch (e) {
      return Left(ApiFailure.general(
          message: 'Failed to load weather forecast data: $e'));
    }
  }
}
