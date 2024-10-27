class SimplifiedWeatherData {
  final String day;
  final double temp;
  final WeatherDescription description;

  SimplifiedWeatherData({required this.day, required this.temp, required this.description});
}

enum WeatherDescription {
  CLEAR,
  PARTLY_SUNNY,
  RAIN
}
