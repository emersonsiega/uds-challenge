import 'package:udschallengeapp/app/modules/recover_password/recover_password_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/modules/recover_password/recover_password_page.dart';

class RecoverPasswordModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => RecoverPasswordBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RecoverPasswordPage();

  static Inject get to => Inject<RecoverPasswordModule>.of();
}
