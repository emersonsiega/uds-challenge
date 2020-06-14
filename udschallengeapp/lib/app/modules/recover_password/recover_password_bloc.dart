import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/api/sendgrid_api.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/recover_password_mail_template_model.dart';
import 'package:udschallengeapp/app/shared/model/user_model.dart';
import 'package:udschallengeapp/app/shared/repositories/user_repository.dart';

class RecoverPasswordBloc extends BlocBase {
  Future<void> recoverPassword(String email) async {
    UserModel user = await _getUser(email);

    await _sendEmail(user);
  }

  Future<UserModel> _getUser(String email) async {
    UserModel user;

    try {
      final _repo = AppModule.to.getDependency<UserRepository>();
      user = await _repo.find(email);
    } catch (ex) {
      print(ex);
      throw new InvalidRequestException(
        "Não foi possível localizar o email",
      );
    }

    if (user == null) {
      throw new InvalidRequestException(
        "O email informado não foi localizado",
      );
    }

    return user;
  }

  Future<void> _sendEmail(UserModel user) async {
    Response response;
    try {
      final _sendgridApi = AppModule.to.getDependency<SendgridApi>();

      final model = RecoverPasswordMailTemplateModel(to: user);

      response = await _sendgridApi.sendPasswordRecovery(model);
    } catch (ex) {
      print(ex);
    }

    if (response == null || response.statusCode != HttpStatus.accepted) {
      throw new InvalidRequestException("Não foi possível enviar o email");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
