import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/modules/login/login_bloc.dart';
import 'package:udschallengeapp/app/modules/login/login_module.dart';
import 'package:udschallengeapp/app/shared/components/toaster.dart';
import 'package:udschallengeapp/app/shared/config/app_routes.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/validator/email_validator.dart';
import 'package:udschallengeapp/app/shared/validator/string_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = LoginModule.to.bloc<LoginBloc>();

  // Email
  final _emailController = TextEditingController();
  final _emailNode = FocusNode();

  // Password
  final _passwordController = TextEditingController();
  final _passwordNode = FocusNode();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
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
                  enabled: !_isLoading,
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
                    ),
                    enabled: !_isLoading,
                    scrollPadding: EdgeInsets.symmetric(vertical: 30),
                    onFieldSubmitted: (_) async {
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
                        "Recuperar senha",
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: ColorPalette.lightBlue,
                            ),
                      ),
                      onPressed: _isLoading ? null : _recoverPassword,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLoading = !_isLoading;
                    });
                  },
                  child: RaisedButton(
                    child: Container(
                      height: 50,
                      child: Center(
                        child: _isLoading
                            ? Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  valueColor: AlwaysStoppedAnimation(
                                    ColorPalette.white,
                                  ),
                                ),
                              )
                            : Text(
                                "ACESSAR",
                                style: Theme.of(context).textTheme.button,
                              ),
                      ),
                    ),
                    onPressed: _login,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: OutlineButton(
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          "CRIAR CONTA",
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: ColorPalette.udsBlue,
                              ),
                        ),
                      ),
                    ),
                    onPressed: _isLoading ? null : _createAccount,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _recoverPassword() async {
    Navigator.of(context)
        .pushNamed(AppRoutes.recoverPassword)
        .then(_setupReceivedEmail);
  }

  Future<void> _createAccount() async {
    Navigator.of(context)
        .pushNamed(AppRoutes.createAccount)
        .then(_setupReceivedEmail);
  }

  void _setupReceivedEmail(email) {
    if (email != null) {
      _formKey.currentState.reset();
      _emailController.text = email;
    }
  }

  Future<void> _login() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _bloc.login(
          _emailController.text,
          _passwordController.text,
        );

        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
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
