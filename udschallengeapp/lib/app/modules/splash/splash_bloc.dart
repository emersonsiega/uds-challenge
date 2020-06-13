import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/blocs/user_session_bloc.dart';
import 'package:udschallengeapp/app/shared/config/app_routes.dart';

class SplashBloc extends BlocBase {
  ///
  /// Check if there's a user logged and returns the future route to be accessed.
  ///
  Future<String> verifyLoggedUser() async {
    final _userSessionBloc = AppModule.to.bloc<UserSessionBloc>();

    // Always show the splash screen for at least 2 seconds
    final responses = await Future.wait([
      _userSessionBloc.loadUser(),
      Future.delayed(Duration(seconds: 2)),
    ]);

    if (responses[0] == null) {
      return AppRoutes.login;
    } else {
      return AppRoutes.home;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
