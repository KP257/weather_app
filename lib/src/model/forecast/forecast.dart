import 'package:open_weather_example_flutter/src/model/weather/weather.dart';

class Forecast {
  final List<WeatherListItem> list;
  final City city;

  Forecast({
    required this.list,
    required this.city,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      list: (json['list'] as List<dynamic>)
          .map((item) => WeatherListItem.fromJson(item))
          .toList(),
      city: City.fromJson(json['city']),
    );
  }
}

class WeatherListItem {
  final int dt;
  final WeatherParams weatherParams;
  final List<WeatherInfo> weatherList;
  final int visibility;
  final String date;

  WeatherListItem({
    required this.dt,
    required this.weatherParams,
    required this.weatherList,
    required this.visibility,
    required this.date,
  });

  factory WeatherListItem.fromJson(Map<String, dynamic> json) {
    return WeatherListItem(
      dt: json['dt'],
      weatherParams: WeatherParams.fromJson(json['main']),
      weatherList: (json['weather'] as List<dynamic>)
          .map((item) => WeatherInfo.fromJson(item))
          .toList(),
      visibility: json['visibility'],
      date: json['dt_txt'],
    );
  }
}

class City {
  final int id;
  final String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

