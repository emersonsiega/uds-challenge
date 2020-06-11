import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/config/error_messages.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/user_model.dart';
import 'package:udschallengeapp/app/shared/repositories/user_repository.dart';

class CreateAccountBloc extends BlocBase {
  final _auth = FirebaseAuth.instance;

  Future<void> createAccount(UserModel user) async {
    FirebaseUser authUser = await _registerAuth(user);

    if (authUser?.uid != null) {
      user.authId = authUser?.uid;

      return await _saveUser(user);
    }
  }

  Future<UserModel> _saveUser(UserModel user) async {
    try {
      final _repo = AppModule.to.getDependency<UserRepository>();
      return await _repo.save(user);
    } on PlatformException catch (ex) {
      print(ex);
      throw new InvalidRequestException(ex.message);
    }
  }

  Future<FirebaseUser> _registerAuth(UserModel user) async {
    AuthResult result;

    try {
      result = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
    } on PlatformException catch (ex) {
      throw InvalidRequestException(
        ErrorMessages.getFrom(
          ex.code,
          orElse: "Não foi possível completar seu cadastro.",
        ),
      );
    } catch (ex) {
      print("CREATE USER FAILED: $ex");

      throw new InvalidRequestException(
        "Não foi possível completar seu cadastro.",
      );
    }

    return result?.user;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
