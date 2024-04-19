import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme
{
  static ThemeData theme = ThemeData(
    primaryColor:  AppColors.rainBlueLight,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor:  const Color(0xfff7f8fb),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    textTheme: const TextTheme(

      // All headings
      titleLarge: TextStyle(fontSize: 20.0, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 12.0, color: Colors.black),
      displayMedium: TextStyle(fontSize: 12.0, color: Color(0xff4c5667)),
      labelMedium: TextStyle(fontSize: 12.0, color: Colors.white),


    ).apply(fontFamily: GoogleFonts.poppins().fontFamily),
  );
}