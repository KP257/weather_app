import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_icon_image.dart';

void main() {
  testWidgets('WeatherIconImage renders correctly', (WidgetTester tester) async {
    // Test data
    const String iconUrl = 'https://openweathermap.org/img/wn/04d@2x.png';
    const double size = 50.0;

        (WidgetTester tester) async {
      mockNetworkImagesFor(() => tester.pumpWidget(const WeatherIconImage(
        iconUrl: iconUrl,
        size: size,
      )));
    };
  });
}
