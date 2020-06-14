import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/blocs/user_session_bloc.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/user_model.dart';

class HomeBloc extends BlocBase {
  Future<UserModel> loadUserData() async {
    final _userSessionBloc = AppModule.to.bloc<UserSessionBloc>();

    try {
      final firebaseUser = await _userSessionBloc.loadUser();

      if (firebaseUser != null) {
        return await _userSessionBloc.loadUserData(firebaseUser.uid);
      }
    } catch (ex) {
      print(ex);
      throw new InvalidRequestException(ex);
    }

    throw InvalidRequestException(
      "Não foi possível carregar os dados do usuário",
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
