import 'package:udschallengeapp/app/modules/splash/splash_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/modules/splash/splash_page.dart';

class SplashModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SplashBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => SplashPage();

  static Inject get to => Inject<SplashModule>.of();
}
