class CurrentWeather {
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final Main? main;
  final int? visibility;
  final Wind? wind;
  final Rain? rain;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  CurrentWeather({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic>? json) {
    return CurrentWeather(
      coord: json != null ? Coord.fromJson(json['coord']) : null,
      weather: json != null
          ? List<Weather>.from(
              json['weather']?.map((x) => Weather.fromJson(x)) ?? [])
          : null,
      base: json?['base'],
      main: json != null ? Main.fromJson(json['main']) : null,
      visibility: json?['visibility'],
      wind: json != null ? Wind.fromJson(json['wind']) : null,
      rain: json != null ? Rain.fromJson(json['rain']) : null,
      clouds: json != null ? Clouds.fromJson(json['clouds']) : null,
      dt: json?['dt'],
      sys: json != null ? Sys.fromJson(json['sys']) : null,
      timezone: json?['timezone'],
      id: json?['id'],
      name: json?['name'],
      cod: json?['cod'],
    );
  }
}

class Coord {
  final double? lon;
  final double? lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic>? json) {
    return Coord(
      lon: json?['lon']?.toDouble(),
      lat: json?['lat']?.toDouble(),
    );
  }
}

class Weather {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic>? json) {
    return Weather(
      id: json?['id'],
      main: json?['main'],
      description: json?['description'],
      icon: json?['icon'],
    );
  }
}

class Main {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  static double? convertKelvinToCelsius(double? kelvin) {
    if (kelvin == null) return null;
    return double.parse((kelvin - 273.15).toStringAsFixed(2));
  }

  factory Main.fromJson(Map<String, dynamic>? json) {
    return Main(
      temp: convertKelvinToCelsius(json?['temp']?.toDouble()),
      feelsLike: convertKelvinToCelsius(json?['feels_like']?.toDouble()),
      tempMin: convertKelvinToCelsius(json?['temp_min']?.toDouble()),
      tempMax: convertKelvinToCelsius(json?['temp_max']?.toDouble()),
      pressure: json?['pressure'],
      humidity: json?['humidity'],
      seaLevel: json?['sea_level'],
      grndLevel: json?['grnd_level'],
    );
  }
}

class Wind {
  final double? speed;
  final int? deg;
  final double? gust;

  Wind({this.speed, this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic>? json) {
    return Wind(
      speed: json?['speed']?.toDouble(),
      deg: json?['deg'],
      gust: json?['gust']?.toDouble(),
    );
  }
}

class Rain {
  final double? oneHour;

  Rain({this.oneHour});

  factory Rain.fromJson(Map<String, dynamic>? json) {
    return Rain(
      oneHour: json?['1h']?.toDouble(),
    );
  }
}

class Clouds {
  final int? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic>? json) {
    return Clouds(
      all: json?['all'],
    );
  }
}

class Sys {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic>? json) {
    return Sys(
      type: json?['type'],
      id: json?['id'],
      country: json?['country'],
      sunrise: json?['sunrise'],
      sunset: json?['sunset'],
    );
  }
}
