import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/color_pallete.dart';
import 'package:udschallengeapp/app/shared/validator/email_validator.dart';
import 'package:udschallengeapp/app/shared/validator/string_validator.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Criar conta",
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
                  scrollPadding: EdgeInsets.symmetric(vertical: 30),
                  onFieldSubmitted: (_) async {
                    await _createAccount();
                  },
                  obscureText: !_showPassword,
                  validator: StringValidator("Senha").validate,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createAccount,
        tooltip: "Criar conta",
        child: Icon(Icons.check),
      ),
    );
  }

  Future<void> _createAccount() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
      //TODO...

      Navigator.of(context).pop(_emailController.text);
    }
  }
}
