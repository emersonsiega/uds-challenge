import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:udschallengeapp/app/shared/config/error_messages.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';

class LoginBloc extends BlocBase {
  final _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    AuthResult result = await _loginFirebaseAuth(email, password);

    print("USER LOGGED IN: ${result?.user?.uid}");
  }

  Future<AuthResult> _loginFirebaseAuth(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result?.user == null) {
        throw new InvalidRequestException("Usuário não localizado");
      }

      return result;
    } on PlatformException catch (ex) {
      throw InvalidRequestException(
        ErrorMessages.getFrom(
          ex.code,
          orElse: "Não foi possível acessar sua conta",
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
