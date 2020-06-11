import 'package:udschallengeapp/app/modules/create_account/create_account_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/modules/create_account/create_account_page.dart';

class CreateAccountModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => CreateAccountBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => CreateAccountPage();

  static Inject get to => Inject<CreateAccountModule>.of();
}
