import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:udschallengeapp/app/app_bloc.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/config/app_routes.dart';

class SplashBloc extends BlocBase {
  ///
  /// Check if there's a user logged and returns the future route to be accessed.
  ///
  Future<String> verifyLoggedUser() async {
    final appBloc = AppModule.to.bloc<AppBloc>();

    // Always show the splash screen for at least 2 seconds
    final responses = await Future.wait([
      appBloc.loadUser(),
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
