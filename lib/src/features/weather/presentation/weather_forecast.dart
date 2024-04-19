import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_icon_image.dart';
import 'package:provider/provider.dart';

import '../../../model/forecast/daily_forecast.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<WeatherProvider, (String city, List<DailyForecast>?)>(
      selector: (context, provider) => (provider.city, provider.dailyForecastList),
      builder: (context, data, _) {
        final List<DailyForecast>? dailyForecastData = data.$2;

        if (dailyForecastData == null || dailyForecastData.isEmpty) {
          return const Center(
            child: SizedBox(), // Show a loading indicator
          );
        }

        return Column(
          children: [
            Text(
              "Daily Forecast",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            ForecastWeatherContents(dailyForecastData: dailyForecastData),
          ],
        );
      },
    );
  }
}

class ForecastWeatherContents extends StatelessWidget {
  const ForecastWeatherContents({super.key, required this.dailyForecastData});

  final List<DailyForecast> dailyForecastData;

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final textTheme = Theme.of(context).textTheme;
    final isCelsius = weatherProvider.isCelsius;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: dailyForecastData.map((dailyForecast) {
            return Column(
              children: [
                Text(dailyForecast.date, style: textTheme.bodyMedium),
                WeatherIconImage(iconUrl: "https://openweathermap.org/img/wn/${dailyForecast.icon}@2x.png", size: 120),
                Text(
                  isCelsius
                      ? '${dailyForecast.averageTemp.toStringAsFixed(1)}°C'
                      : '${((dailyForecast.averageTemp * 9 / 5) + 32).toStringAsFixed(1)}°F',
                  style: textTheme.bodyMedium,
                ),
                Text(dailyForecast.description, style: textTheme.bodyMedium),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}





