import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:udschallengeapp/app/modules/create_account/create_account_bloc.dart';
import 'package:udschallengeapp/app/modules/create_account/create_account_module.dart';

void main() {
  initModule(CreateAccountModule());
  CreateAccountBloc bloc;

  setUp(() {
    bloc = CreateAccountModule.to.bloc<CreateAccountBloc>();
  });

  group('CreateAccountBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<CreateAccountBloc>());
    });
  });
}
