import 'package:udschallengeapp/app/modules/topics/topics_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/modules/topics/topics_page.dart';

class TopicsModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => TopicsBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => TopicsPage();

  static Inject get to => Inject<TopicsModule>.of();
}
