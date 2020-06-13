import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/user_model.dart';
import 'package:udschallengeapp/app/shared/repositories/user_repository.dart';

class UserSessionBloc extends BlocBase {
  final _userSessionController = BehaviorSubject<UserModel>();

  ValueStream<UserModel> get userStream => _userSessionController.stream;

  Future<UserModel> loadUserData(String authId) async {
    final repo = AppModule.to.getDependency<UserRepository>();

    try {
      final user = await repo.find(authId, field: "authId");
      _userSessionController.sink.add(user);
      return user;
    } catch (ex) {
      print(ex);
      throw new InvalidRequestException("Não foi possível carregar o usuário");
    }
  }

  Future<FirebaseUser> loadUser() async {
    try {
      final auth = FirebaseAuth.instance;
      return await auth.currentUser();
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  void clearUser() {
    _userSessionController.add(UserModel());
  }

  @override
  void dispose() {
    _userSessionController.close();
    super.dispose();
  }
}
