import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/modules/home/home_module.dart';
import 'package:udschallengeapp/app/shared/config/app_theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pautas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme,
      home: HomeModule(),
    );
  }
}
