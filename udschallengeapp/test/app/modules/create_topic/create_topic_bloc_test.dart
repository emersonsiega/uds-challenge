import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:udschallengeapp/app/modules/create_topic/create_topic_bloc.dart';
import 'package:udschallengeapp/app/modules/create_topic/create_topic_module.dart';

void main() {
  initModule(CreateTopicModule());
  CreateTopicBloc bloc;

  setUp(() {
    bloc = CreateTopicModule.to.bloc<CreateTopicBloc>();
  });

  group('CreateTopicBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<CreateTopicBloc>());
    });
  });
}
