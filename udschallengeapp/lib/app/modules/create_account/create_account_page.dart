import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/modules/create_account/create_account_bloc.dart';
import 'package:udschallengeapp/app/modules/create_account/create_account_module.dart';
import 'package:udschallengeapp/app/shared/components/custom_app_bar.dart';
import 'package:udschallengeapp/app/shared/components/loading_action_button.dart';
import 'package:udschallengeapp/app/shared/components/toaster.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/user_model.dart';
import 'package:udschallengeapp/app/shared/validator/email_validator.dart';
import 'package:udschallengeapp/app/shared/validator/string_validator.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _bloc = CreateAccountModule.to.bloc<CreateAccountBloc>();

  // Name
  final _nameController = TextEditingController();
  final _nameNode = FocusNode();

  // Email
  final _emailController = TextEditingController();
  final _emailNode = FocusNode();

  // Password
  final _passwordController = TextEditingController();
  final _passwordNode = FocusNode();

  bool _showPassword = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Criar conta",
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                focusNode: _nameNode,
                decoration: InputDecoration(
                  labelText: "Nome",
                  helperText: " ",
                  prefixIcon: Icon(Icons.person),
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_emailNode);
                },
                enabled: !_isLoading,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: StringValidator("Nome", 3).validate,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: TextFormField(
                  controller: _emailController,
                  focusNode: _emailNode,
                  decoration: InputDecoration(
                    labelText: "Email",
                    helperText: " ",
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                  enabled: !_isLoading,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: EmailValidator("Email").validate,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    helperText: "Verifique a senha antes de confirmar",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  enabled: !_isLoading,
                  scrollPadding: EdgeInsets.symmetric(vertical: 30),
                  onFieldSubmitted: (_) async {
                    await _createAccount();
                  },
                  obscureText: !_showPassword,
                  validator: StringValidator("Senha", 6).validate,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: LoadingActionButton(
        onPressed: _createAccount,
        tooltip: "Criar conta",
        isLoading: _isLoading,
        icon: Icons.check,
      ),
    );
  }

  Future<void> _createAccount() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
        _showPassword = false;
      });

      try {
        final user = UserModel(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          name: _nameController.text,
        );

        await _bloc.createAccount(user);

        Navigator.of(context).pop(_emailController.text);
      } on InvalidRequestException catch (ex) {
        Toaster.showError(
          context,
          ex.cause,
        );
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
