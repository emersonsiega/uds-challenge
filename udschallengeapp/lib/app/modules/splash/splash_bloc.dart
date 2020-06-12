import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udschallengeapp/app/shared/config/app_routes.dart';

class SplashBloc extends BlocBase {
  ///
  /// Check if there's a user logged and returns the future route to be accessed.
  ///
  Future<String> verifyLoggedUser() async {
    // Always show the splash screen for at least 2 seconds
    final responses = await Future.wait([
      _loadUser(),
      Future.delayed(Duration(seconds: 2)),
    ]);

    if (responses[0] == null) {
      return AppRoutes.login;
    } else {
      return AppRoutes.home;
    }
  }

  Future<FirebaseUser> _loadUser() async {
    try {
      final auth = FirebaseAuth.instance;
      return await auth.currentUser();
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
