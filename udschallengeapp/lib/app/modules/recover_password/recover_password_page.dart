import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/modules/recover_password/recover_password_bloc.dart';
import 'package:udschallengeapp/app/modules/recover_password/recover_password_module.dart';
import 'package:udschallengeapp/app/shared/components/custom_app_bar.dart';
import 'package:udschallengeapp/app/shared/components/loading_action_button.dart';
import 'package:udschallengeapp/app/shared/components/toaster.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/validator/email_validator.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = RecoverPasswordModule.to.bloc<RecoverPasswordBloc>();

  // Email
  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Recuperar senha",
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Informe seu email de cadastro para recuperar sua senha.",
                  style: Theme.of(context).textTheme.subhead.copyWith(
                        color: ColorPalette.black,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  helperText: " ",
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                onFieldSubmitted: (_) async {
                  await _recoverPassword();
                },
                enabled: !_isLoading,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: EmailValidator("Email").validate,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: LoadingActionButton(
        onPressed: _recoverPassword,
        tooltip: "Recuperar senha",
        isLoading: _isLoading,
        icon: Icons.check,
      ),
    );
  }

  Future<void> _recoverPassword() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _bloc.recoverPassword(_emailController.text);

        Navigator.of(context).pop(_emailController.text);
      } on InvalidRequestException catch (ex) {
        Toaster.showError(context, ex.cause);
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
