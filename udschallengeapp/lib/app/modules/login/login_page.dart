import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/app_routes.dart';
import 'package:udschallengeapp/app/shared/config/color_pallete.dart';
import 'package:udschallengeapp/app/shared/validator/email_validator.dart';
import 'package:udschallengeapp/app/shared/validator/string_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Email
  final _emailController = TextEditingController();
  final _emailNode = FocusNode();

  // Password
  final _passwordController = TextEditingController();
  final _passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 48.0,
                ),
                child: Image.asset("assets/logo.png"),
              ),
              TextFormField(
                controller: _emailController,
                focusNode: _emailNode,
                decoration: InputDecoration(
                  labelText: "Email",
                  helperText: " ",
                  prefixIcon: Icon(Icons.person),
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordNode);
                },
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: EmailValidator("Email").validate,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    helperText: " ",
                    prefixIcon: Icon(Icons.lock),
                    filled: true,
                    fillColor: ColorPallete.white,
                  ),
                  scrollPadding: EdgeInsets.symmetric(vertical: 30),
                  onFieldSubmitted: (_) async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await _login();
                  },
                  obscureText: true,
                  validator: StringValidator("Senha").validate,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "Esqueci minha senha",
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: ColorPallete.lightBlue,
                          ),
                    ),
                    onPressed: _recoverPassword,
                  ),
                ],
              ),
              RaisedButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "ACESSAR",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                onPressed: _login,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: OutlineButton(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "CRIAR CONTA",
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: ColorPallete.udsBlue,
                          ),
                    ),
                  ),
                  onPressed: _createAccount,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _recoverPassword() async {
    // TODO..
    Navigator.of(context).pushNamed(AppRoutes.recoverPassword);
  }

  Future<void> _createAccount() async {
    // TODO..
    Navigator.of(context).pushNamed(AppRoutes.createAccount);
  }

  Future<void> _login() async {
    if (_formKey.currentState.validate()) {
      // TODO login
    }
  }
}
