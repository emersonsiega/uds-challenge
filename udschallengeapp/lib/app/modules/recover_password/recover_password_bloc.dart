import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/user_model.dart';
import 'package:udschallengeapp/app/shared/repositories/user_repository.dart';

class RecoverPasswordBloc extends BlocBase {
  Future<void> recoverPassword(String email) async {
    UserModel user;
    try {
      final _repo = AppModule.to.getDependency<UserRepository>();
      user = await _repo.find(email);
    } catch (ex) {
      throw new InvalidRequestException(
        "Não foi possível localizar o email",
      );
    }

    if (user == null) {
      throw new InvalidRequestException(
        "O email informado não foi localizado",
      );
    }

    //TODO: Send email
  }

  @override
  void dispose() {
    super.dispose();
  }
}
