import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/models/api_responses/current_weather.dart';
import 'package:weather_app/domain/models/api_responses/weather_forcast.dart';
import 'package:weather_app/domain/models/core_failures/abstract_core_failure.dart';
import 'package:weather_app/domain/models/core_failures/api_failure.dart';
import 'package:weather_app/domain/models/simplified_weather_data.dart';
import 'package:weather_app/domain/repositories/interfaces/i_weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

@Injectable()
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final IWeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(WeatherInitial()) {
    on<FetchWeatherEvent>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      var currentWeatherData = await _weatherRepository.getCurrentWeather();
      await currentWeatherData.fold(
        (failure) async {
          emit(WeatherError(failure));
        },
        (currentWeather) async {
          var weatherForecastData =
              await _weatherRepository.getWeatherForecast();
          weatherForecastData.fold(
            (failure) {
              emit(WeatherError(failure));
            },
            (weatherForecast) {
              var simplifiedData =
                  _aggregateAndSimplifyWeatherData(weatherForecast.list);
              emit(WeatherDataLoaded(currentWeather, simplifiedData));
            },
          );
        },
      );
    } catch (e) {
      emit(
        WeatherError(
          ApiFailure.general(
            message: e.toString(),
          ),
        ),
      );
    }
  }

  List<SimplifiedWeatherData> _aggregateAndSimplifyWeatherData(
      List<WeatherData>? list) {
    Map<String, List<double>> groupedByDay = {};

    if (list == null) {
      return [];
    }

    for (var item in list) {
      if (item.dtTxt != null && item.main != null) {
        String day = DateFormat('EEEE').format(DateTime.parse(item.dtTxt!));
        // End of  Selection
        double temp = item.main!.temp!;
        groupedByDay.putIfAbsent(day, () => []).add(temp);
      }
    }

    List<SimplifiedWeatherData> dailyForecast = [];
    groupedByDay.forEach((day, temperatures) {
      double averageTemp =
          temperatures.reduce((a, b) => a + b) / temperatures.length - 273.15;
      dailyForecast.add(SimplifiedWeatherData(
          day: day,
          temp: averageTemp,
          description:
              WeatherDescription.CLEAR)); //TODO get the weather description
    });
    return dailyForecast;
  }
}
