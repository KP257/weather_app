import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_icon_image.dart';
import 'package:provider/provider.dart';

import '../../../model/weather/weather.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<WeatherProvider, (String city, Weather?)>(
      selector: (context, provider) => (provider.city, provider.currentWeatherProvider),
      builder: (context, data, _) {

        final String city = data.$1;
        final Weather? weatherData = data.$2;

        if (weatherData == null) {
          return const Center(
            child: SizedBox(), // Show a loading indicator
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Current Weather",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Text(
              city,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            CurrentWeatherContents(weatherData: weatherData),
          ],
        );
      },
    );
  }}

class CurrentWeatherContents extends StatelessWidget {
  const CurrentWeatherContents({super.key, required this.weatherData});

  final Weather weatherData;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

   // Checks if the isCelsius value in the provider has changed
    final temp = Provider.of<WeatherProvider>(context).isCelsius
        ? weatherData.weatherParams.temp.celsius
        : weatherData.weatherParams.temp.fahrenheit;
    final minTemp = Provider.of<WeatherProvider>(context).isCelsius
        ? weatherData.weatherParams.tempMin.celsius
        : weatherData.weatherParams.tempMin.fahrenheit;
    final maxTemp = Provider.of<WeatherProvider>(context).isCelsius
        ? weatherData.weatherParams.tempMax.celsius
        : weatherData.weatherParams.tempMax.fahrenheit;

    final highAndLow = 'H:$maxTemp L:$minTemp';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(iconUrl: "https://openweathermap.org/img/wn/${weatherData.weatherInfo[0].icon}@2x.png", size: 120),
        Text(temp, style: textTheme.bodyMedium),
        Text(highAndLow, style: textTheme.bodyMedium),
      ],
    );
  }
}
