import 'package:flutter/material.dart';

// Changed CachedImage to Image.network due to depreciation
class WeatherIconImage extends StatelessWidget {
  const WeatherIconImage(
      {super.key, required this.iconUrl, required this.size});
  final String iconUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      iconUrl,
      width: size,
      height: size,
    );
  }
}
