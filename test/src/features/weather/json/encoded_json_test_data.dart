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