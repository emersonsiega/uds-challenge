import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:udschallengeapp/app/shared/model/recover_password_mail_template_model.dart';

class SendgridApi extends Disposable {
  Future<Response> sendPasswordRecovery(
    RecoverPasswordMailTemplateModel model,
  ) async {
    await DotEnv().load();

    final _apiKey = DotEnv().env["SENDGRID_API_KEY"];

    assert(
      _apiKey != null && _apiKey.isNotEmpty,
      "You must define the SendGrid API Key (.env file)",
    );

    Response response = await Dio().post(
      'https://api.sendgrid.com/v3/mail/send',
      data: model.mailModel.toJson(),
      options: Options(
        contentType: "application/json",
        headers: {
          "Authorization": "Bearer $_apiKey",
        },
      ),
    );

    return response;
  }

  @override
  void dispose() {}
}
