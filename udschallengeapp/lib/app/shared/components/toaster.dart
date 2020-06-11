import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:udschallengeapp/app/shared/config/color_pallete.dart';

class Toaster {
  static void showError(BuildContext context, String message) {
    Toast.show(
      message,
      context,
      backgroundColor: ColorPallete.red,
      textColor: ColorPallete.white,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
    );
  }

  static void showInfo(BuildContext context, String message) {
    Toast.show(
      message,
      context,
      backgroundColor: ColorPallete.udsBlue,
      textColor: ColorPallete.white,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
    );
  }
}
