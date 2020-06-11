import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:udschallengeapp/app/modules/recover_password/recover_password_bloc.dart';
import 'package:udschallengeapp/app/modules/recover_password/recover_password_module.dart';

void main() {
  initModule(RecoverPasswordModule());
  RecoverPasswordBloc bloc;

  setUp(() {
    bloc = RecoverPasswordModule.to.bloc<RecoverPasswordBloc>();
  });

  group('RecoverPasswordBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<RecoverPasswordBloc>());
    });
  });
}
