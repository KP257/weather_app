import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/api/api_keys.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/src/model/forecast/forecast.dart';

import '../../../model/forecast/daily_forecast.dart';
import '../../../model/weather/weather.dart';
import 'dart:math';

class WeatherProvider extends ChangeNotifier {
  HttpWeatherRepository repository = HttpWeatherRepository(
    api: OpenWeatherMapAPI(sl<String>(instanceName: 'api_key')),
    client: http.Client(),
  );

  bool _isCelsius = true;
  bool get isCelsius => _isCelsius;

  String city = '';
  Weather? currentWeatherProvider;
  List<DailyForecast> dailyForecastList = [];

  Future<void> getWeatherData() async {
    dailyForecastList.clear();

    await getCurrentWeather();
    await getForecast();

    notifyListeners();
  }

  Future<void> getCurrentWeather() async {
    final weather = await repository.getWeather(city: city);
    currentWeatherProvider = Weather.fromJson(weather);
  }

  Future<void> getForecast() async {
    final forecasts = await repository.getWeatherForecast(city: city);
    Forecast forecast = Forecast.fromJson(forecasts);

    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    forecast.list.removeWhere((weatherListItem) {
      String forecastDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(weatherListItem.date));
      return forecastDate == today;
    });

    for (var i = 0; i < forecast.list.length / 8; i++) {
      var dailyForecast = DailyForecast.calculateDailyForecast(forecast.list.sublist(i * 8, min((i + 1) * 8, forecast.list.length)));
      dailyForecastList.add(dailyForecast);
    }
  }

  void toggleTemperatureUnit(bool isCelsius) {
    _isCelsius = isCelsius;
    notifyListeners();
  }


}




