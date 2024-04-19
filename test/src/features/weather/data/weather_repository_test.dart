import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/api_exception.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';
import 'package:open_weather_example_flutter/src/model/forecast/forecast.dart';
import 'package:open_weather_example_flutter/src/model/weather/weather.dart';

class MockHttpClient extends Mock implements http.Client {}

// Your JSON-encoded weather data as a string
const encodedCurrentWeatherJsonResponse = """
{
  "coord": {"lon": -122.0838, "lat": 37.3861},
  "weather": [{"id": 803, "main": "Clouds", "description": "broken clouds", "icon": "04n"}],
  "base": "stations",
  "main": {
    "temp": 10.43,
    "feels_like": 9.88,
    "temp_min": 8.35,
    "temp_max": 12.23,
    "pressure": 1013,
    "humidity": 87
  },
  "visibility": 10000,
  "wind": {"speed": 3.09, "deg": 140},
  "clouds": {"all": 75},
  "dt": 1713529262,
  "sys": {
    "type": 2,
    "id": 2089760,
    "country": "US",
    "sunrise": 1713533232,
    "sunset": 1713581221
  },
  "timezone": -25200,
  "id": 5375480,
  "name": "Mountain View",
  "cod": 200
}
""";

const encodedForecastWeatherJsonResponse = """
{
    "cod": "200",
    "message": 0,
    "cnt": 40,
    "list": [
        {
            "dt": 1713538800,
            "main": {
                "temp": 11.46,
                "feels_like": 10.7,
                "temp_min": 11.46,
                "temp_max": 13.71,
                "pressure": 1014,
                "sea_level": 1014,
                "grnd_level": 993,
                "humidity": 78,
                "temp_kf": -2.25
            },
            "weather": [
                {
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 78
            },
            "wind": {
                "speed": 0.67,
                "deg": 279,
                "gust": 0.71
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2024-04-19 15:00:00"
        }
    ],
    "city": {
        "id": 5375480,
        "name": "Mountain View",
        "coord": {
            "lat": 37.3861,
            "lon": -122.0838
        },
        "country": "US",
        "population": 74066,
        "timezone": -25200,
        "sunrise": 1713533232,
        "sunset": 1713581221
    }
}
""";

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