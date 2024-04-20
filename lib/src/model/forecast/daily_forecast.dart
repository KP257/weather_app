import 'package:intl/intl.dart';

import '../weather/weather.dart';
import 'forecast.dart';

class DailyForecast {
  final double averageTemp;
  final String icon;
  final String description;
  final String date;
  final String city;
  final int id;

  DailyForecast({
    required this.averageTemp,
    required this.icon,
    required this.description,
    required this.date,
    required this.city,
    required this.id
  });

  static DailyForecast calculateDailyForecast(List<WeatherListItem> dayData, City city) {
    if (dayData.isEmpty) {
      return DailyForecast(
        averageTemp: 0,
        icon: '',
        description: 'No data',
        date: '',
        city: '',
        id: 0,
      );
    }

    double totalTemp = 0;
    WeatherInfo representativeWeatherInfo = dayData[dayData.length ~/ 2].weatherList.first;

    for (var entry in dayData) {
      totalTemp += entry.weatherParams.temp;
    }

    double averageTemp = totalTemp / dayData.length;


    String formattedDate = DateFormat('EEEE').format(DateTime.parse(dayData.first.date));

    return DailyForecast(
        averageTemp: averageTemp,
        icon: representativeWeatherInfo.icon,
        description: representativeWeatherInfo.description,
        date: formattedDate, city: city.name,
      id: city.id
    );
  }}
