import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/api_exception.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';
import 'package:open_weather_example_flutter/src/model/forecast/forecast.dart';
import 'package:open_weather_example_flutter/src/model/weather/weather.dart';

import '../json/encoded_json_test_data.dart';

class MockHttpClient extends Mock implements http.Client {}




final decodedWeatherData = json.decode(encodedCurrentWeatherJsonResponse);
final expectedWeather = Weather.fromJson(decodedWeatherData);

final decodedForecastData = json.decode(encodedForecastWeatherJsonResponse);
final expectedForecast = Forecast.fromJson(decodedForecastData);

void main() {
  registerFallbackValue(Uri());
  late MockHttpClient mockHttpClient;
  late HttpWeatherRepository mockWeatherRepo;

  setUp(() {
    mockHttpClient = MockHttpClient();
    final apiKey = OpenWeatherMapAPI('5bdec13c25b820e7e456c4191f4af978');
    mockWeatherRepo = HttpWeatherRepository(api: apiKey, client: mockHttpClient);
  });

  group("HttpWeatherRepo", () {
    test('repository with mocked http client, getCurrentWeather success', () async {
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response(encodedCurrentWeatherJsonResponse, 200));
      final weatherData = await mockWeatherRepo.getWeather(city: 'Mountain View');
      final weather = Weather.fromJson(weatherData);

      expect(weather.id, expectedWeather.id);
      expect(weather.name, expectedWeather.name);
    });

    test('repository with mocked http client, getWeatherForecast success', () async {
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response(encodedForecastWeatherJsonResponse, 200));
      final forecastData = await mockWeatherRepo.getWeatherForecast(city: 'Mountain View');
      final weather = Forecast.fromJson(forecastData);

      expect(weather.city.id, expectedForecast.city.id);
      expect(weather.city.name, expectedForecast.city.name);
    });

    test('repository with mocked http client, failure', () async {
      when(() => mockHttpClient.get(any())).thenAnswer((_) async => http.Response('', 404));
      expect(() async => await mockWeatherRepo.getWeather(city: 'NotACity'), throwsA(isA<CityNotFoundException>()));
    });
  });



}