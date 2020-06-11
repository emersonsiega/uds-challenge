import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/color_pallete.dart';
import 'package:udschallengeapp/app/shared/validator/email_validator.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  // Email
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recuperar senha",
          style: Theme.of(context).textTheme.headline.copyWith(
                color: ColorPallete.black,
                fontWeight: FontWeight.w500,
              ),
        ),
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
                        color: ColorPallete.black,
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
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: EmailValidator("Email").validate,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _recoverPassword,
        tooltip: "Recuperar senha",
        child: Icon(Icons.check),
      ),
    );
  }

  Future<void> _recoverPassword() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
      //TODO...

      Navigator.of(context).pop(_emailController.text);
    }
  }
}
