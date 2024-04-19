class Weather {
  final int id;
  final WeatherParams weatherParams;
  final List<WeatherInfo> weatherInfo;
  final String name;

  Weather({
    required this.id,
    required this.weatherParams,
    required this.weatherInfo,
    required this.name
  });

  factory Weather.fromJson(Map<String, dynamic> json) {

    return Weather(
        id: json['id'],
        weatherParams: WeatherParams.fromJson(json['main']),
        weatherInfo: (json['weather'] as List)
            .map((infoJson) => WeatherInfo.fromJson(infoJson))
            .toList(),
        name: json['name']
    );
  }
}

class WeatherParams {
  final double temp;
  final double tempMin;
  final double tempMax;

  WeatherParams({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  factory WeatherParams.fromJson(Map<String, dynamic> json) {
    return WeatherParams(
      temp: json['temp'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
    );
  }
}extension TemperatureExtension on double {
  String get celsius => '${toInt()}°C';
  String get fahrenheit => '${((this * 9 / 5) + 32).toInt()}°F';
}

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      description: json['description'],
      icon: json['icon'],
    );
  }
}