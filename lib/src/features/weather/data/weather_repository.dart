import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:open_weather_example_flutter/src/api/api.dart';

import 'api_exception.dart';

class HttpWeatherRepository {
  final OpenWeatherMapAPI api;
  final http.Client client;

  HttpWeatherRepository({required this.api, required this.client});

  Future<Map<String, dynamic>> getWeather({required String city}) async {
    OpenWeatherMapAPI openWeatherMapAPI = OpenWeatherMapAPI(api.apiKey);
    final weatherUri = openWeatherMapAPI.weather(city);
    final response = await _handleData(weatherUri: weatherUri);
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> getWeatherForecast({required String city}) async {
    OpenWeatherMapAPI openWeatherMapAPI = OpenWeatherMapAPI(api.apiKey);
    final weatherUri = openWeatherMapAPI.forecast(city);
    final response = await _handleData(weatherUri: weatherUri);
    return json.decode(response.body);
  }

  Future<http.Response> _handleData({required Uri weatherUri})
  async {
    try {
      final response = await http.get(weatherUri);
      switch (response.statusCode) {
        case 200:
          return response;
        case 401:
          throw InvalidApiKeyException();
        case 404:
          throw CityNotFoundException();
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }


}

