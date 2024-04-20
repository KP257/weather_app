import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/api/api_keys.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';
import 'package:open_weather_example_flutter/src/model/forecast/daily_forecast.dart';
import 'package:open_weather_example_flutter/src/model/forecast/forecast.dart';
import 'package:open_weather_example_flutter/src/model/weather/weather.dart';
import 'package:http/http.dart' as http;

import '../json/encoded_json_test_data.dart';
import 'weather_repository_test.dart';


void main() {
  registerFallbackValue(Uri());
  setupInjection();
  late MockHttpClient mockHttpClient;
  late HttpWeatherRepository mockWeatherRepo;
  late WeatherProvider mockWeatherProvider;

  setUp(() {
    mockHttpClient = MockHttpClient();
    final apiKey = OpenWeatherMapAPI(sl<String>(instanceName: 'api_key'));
    mockWeatherRepo = HttpWeatherRepository(api: apiKey, client: mockHttpClient);
    mockWeatherProvider = WeatherProvider();
  });

  test('provider with mocked http client, getCurrentWeatherProvider success', () async {
    when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response(encodedCurrentWeatherJsonResponse, 200));
    final weatherData = await mockWeatherRepo.getWeather(city: 'Mountain View');
    final weather = Weather.fromJson(weatherData);

    mockWeatherProvider.currentWeatherProvider = weather;
    Weather? currentWeatherData = mockWeatherProvider.currentWeatherProvider;

    expect(currentWeatherData!.id, weather.id);
    expect(currentWeatherData.name, weather.name);

  });

  test('provider with mocked http client, calculating daily forecast, getWeatherForecastProvider success', () async {
    when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response(encodedForecastWeatherJsonResponse, 200));
    final forecastData = await mockWeatherRepo.getWeatherForecast(city: 'Mountain View');
    final forecast = Forecast.fromJson(forecastData);

    List<DailyForecast> mockDailyForecastList = [];
    for (var i = 0; i < forecast.list.length / 8; i++) {
      var dailyForecast = DailyForecast.calculateDailyForecast(forecast.list.sublist(i * 8, min((i + 1) * 8, forecast.list.length)), forecast.city);
      mockDailyForecastList.add(dailyForecast);
    }

    mockWeatherProvider.dailyForecastList = mockDailyForecastList;
    List<DailyForecast>? dailyForecast = mockWeatherProvider.dailyForecastList;

    expect(dailyForecast[0].city, mockWeatherProvider.dailyForecastList[0].city);
    expect(dailyForecast[0].id, mockWeatherProvider.dailyForecastList[0].id);
  });



}
