import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:udschallengeapp/app/app_bloc.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/user_model.dart';

class HomeBloc extends BlocBase {
  Future<UserModel> loadUserData() async {
    final appBloc = AppModule.to.bloc<AppBloc>();

    try {
      final firebaseUser = await appBloc.loadUser();

      if (firebaseUser != null) {
        return await appBloc.loadUserData(firebaseUser.uid);
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
