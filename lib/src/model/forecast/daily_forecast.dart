import 'package:intl/intl.dart';

import '../weather/weather.dart';
import 'forecast.dart';

class DailyForecast {
  final double averageTemp;
  final String icon;
  final String description;
  final String date;

  DailyForecast({
    required this.averageTemp,
    required this.icon,
    required this.description,
    required this.date,
  });

  static DailyForecast calculateDailyForecast(List<WeatherListItem> dayData) {
    if (dayData.isEmpty) {
      return DailyForecast(
        averageTemp: 0,
        icon: '',  // Default icon or a placeholder
        description: 'No data',
        date: '',
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
        date: formattedDate
    );
  }}
