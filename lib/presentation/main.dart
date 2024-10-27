import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/weather_bloc.dart';
import 'package:weather_app/domain/models/api_responses/current_weather.dart';
import 'package:weather_app/domain/models/simplified_weather_data.dart';
import 'package:weather_app/injection.dart';

void main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WeatherBloc>()..add(FetchWeatherEvent()),
      child: _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherError) {
            return const Center(child: Text('Error: error')); //todo
          } else if (state is WeatherDataLoaded) {
            return Column(
              children: [
                _buildWeatherContent(state.currentWeather, context),
                _buildForecastContent(state.weatherForecast, context)
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildWeatherContent(
      CurrentWeather currentWeather, BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/forest_sunny.png"), //background changes depending on datetime as in day or night as well as the weather being sunny or rainy or overcast etc..
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${currentWeather.main?.temp}°C',
                style: const TextStyle(fontSize: 64, color: Colors.white),
              ),
              Text(
                currentWeather.weather?[0].description ?? '',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.green,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        '${currentWeather.main?.tempMin?.toStringAsFixed(1)}° min'),
                    Text(
                        '${currentWeather.main?.temp?.toStringAsFixed(1)}° Current'),
                    Text(
                        '${currentWeather.main?.tempMax?.toStringAsFixed(1)}° max'),
                  ],
                ),
              ),
              const Divider(color: Colors.white),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildForecastContent(
      List<SimplifiedWeatherData> forecast, BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final dayForecast = forecast[index];
          return ListTile(
            leading: Text(dayForecast.day),
            title: Text('ICON PLACEHOLDER'),
            trailing: Text('${dayForecast.temp.toStringAsFixed(1)}°C'),
          );
        },
      ),
    );
  }
}
