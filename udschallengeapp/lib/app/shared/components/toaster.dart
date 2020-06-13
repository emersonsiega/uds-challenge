import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';

class Toaster {
  static void showError(BuildContext context, String message) {
    Toast.show(
      message,
      context,
      backgroundColor: ColorPalette.red,
      textColor: ColorPalette.white,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
    );
  }

  static void showInfo(BuildContext context, String message) {
    Toast.show(
      message,
      context,
      backgroundColor: ColorPalette.lightBlue,
      textColor: ColorPalette.white,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
    );
  }
}
