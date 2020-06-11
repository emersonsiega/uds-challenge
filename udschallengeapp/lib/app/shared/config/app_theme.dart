import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/color_pallete.dart';

class AppTheme {
  static ThemeData get buildTheme {
    return ThemeData(
      primaryColor: ColorPallete.udsBlue,
      accentColor: ColorPallete.lightBlue,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
      ),
      textTheme: TextTheme(
        button: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorPallete.white,
        ),
      ),
    );
  }
}
