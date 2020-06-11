import 'package:udschallengeapp/app/modules/create_topic/create_topic_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/modules/create_topic/create_topic_page.dart';

class CreateTopicModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => CreateTopicBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => CreateTopicPage();

  static Inject get to => Inject<CreateTopicModule>.of();
}
