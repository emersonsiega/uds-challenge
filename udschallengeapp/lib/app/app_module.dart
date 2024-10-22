import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/app_bloc.dart';
import 'package:udschallengeapp/app/app_widget.dart';
import 'package:udschallengeapp/app/shared/api/sendgrid_api.dart';
import 'package:udschallengeapp/app/shared/blocs/user_session_bloc.dart';
import 'package:udschallengeapp/app/shared/blocs/user_topics_bloc.dart';
import 'package:udschallengeapp/app/shared/repositories/topic_repository.dart';
import 'package:udschallengeapp/app/shared/repositories/user_repository.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
        Bloc((i) => UserSessionBloc()),
        Bloc((i) => UserTopicsBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => SendgridApi()),
        Dependency((i) => TopicRepository()),
        Dependency((i) => UserRepository()),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
