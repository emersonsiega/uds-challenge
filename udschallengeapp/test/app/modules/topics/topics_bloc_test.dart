import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:udschallengeapp/app/modules/topics/topics_bloc.dart';
import 'package:udschallengeapp/app/modules/topics/topics_module.dart';

void main() {
  initModule(TopicsModule());
  TopicsBloc bloc;

  setUp(() {
    bloc = TopicsModule.to.bloc<TopicsBloc>();
  });

  group('TopicsBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<TopicsBloc>());
    });
  });
}
