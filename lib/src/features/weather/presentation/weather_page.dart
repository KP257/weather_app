import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/city_search_box.dart';
import 'package:provider/provider.dart';

import '../application/providers.dart';
import 'current_weather.dart';
import 'weather_forecast.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key, required this.city});
  final String city;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.rainGradient,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                minWidth: 300
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  // Title
                  Text("Weather App", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),

                  const CitySearchBox(),

                  // Switch to switch between celsius and fahrenheit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("°F", style: textTheme.bodyMedium),
                      Switch(
                        activeColor: AppColors.accentColor,
                        value: Provider.of<WeatherProvider>(context).isCelsius,
                        onChanged: (value) {
                          Provider.of<WeatherProvider>(context, listen: false).toggleTemperatureUnit(value);
                        },
                      ),
                      Text("°C", style: textTheme.bodyMedium),
                    ],
                  ),

                  // Current weather and forecast
                  const CurrentWeather(),
                  const WeatherForecast(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
