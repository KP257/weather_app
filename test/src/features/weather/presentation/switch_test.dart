import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_example_flutter/src/api/api_keys.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Switch changes temperature unit', (WidgetTester tester) async {
    setupInjection();

    final weatherProvider = WeatherProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: weatherProvider,
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Switch(
                  activeColor: Colors.blue, // Your activeColor here
                  value: Provider.of<WeatherProvider>(context).isCelsius,
                  onChanged: (value) {
                    Provider.of<WeatherProvider>(context, listen: false)
                        .toggleTemperatureUnit(value);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    expect(weatherProvider.isCelsius, true);

    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(weatherProvider.isCelsius, false); // Assuming it should toggle to Fahrenheit
  });
}
