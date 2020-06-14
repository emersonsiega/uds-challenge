import 'package:udschallengeapp/app/shared/model/sendgrid_mail_send_model.dart';
import 'package:udschallengeapp/app/shared/model/user_model.dart';

class RecoverPasswordMailTemplateModel {
  static const String _templateId = "d-e1647a48335645a2b60c44c160a0cb4a";

  static const From _sender = const From(
    email: "emersonsiega@gmail.com",
    name: "App Pautas",
  );

  final SendgridMailSendModel _mailModel;

  RecoverPasswordMailTemplateModel({
    UserModel to,
  }) : _mailModel = SendgridMailSendModel(
          templateId: _templateId,
          from: _sender,
          personalizations: [
            Personalizations(
              dynamicTemplateData: DynamicTemplateData(
                userName: to.name,
                userPassword: to.password,
              ),
              to: [
                To(email: to.email),
              ],
            ),
          ],
        );

  SendgridMailSendModel get mailModel => _mailModel;
}
