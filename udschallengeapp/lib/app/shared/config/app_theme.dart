import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/color_pallete.dart';

class AppTheme {
  static ThemeData get buildTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: ColorPallete.black,
        ),
        actionsIconTheme: IconThemeData(
          color: ColorPallete.black,
        ),
      ),
      primaryColor: ColorPallete.udsBlue,
      accentColor: ColorPallete.udsBlue,
      buttonColor: ColorPallete.udsBlue,
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
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
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
