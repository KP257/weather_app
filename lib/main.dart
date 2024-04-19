import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/api/api_keys.dart';
import 'package:open_weather_example_flutter/src/constants/theme.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_page.dart';
import 'package:provider/provider.dart';

void main() {
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<WeatherProvider>(
        create: (_) => WeatherProvider(),
        lazy: false,
        child: const WeatherPage(city: 'London'),
      ),
    );
  }
}
