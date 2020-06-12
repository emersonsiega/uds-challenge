import 'package:udschallengeapp/app/modules/create_account/create_account_module.dart';
import 'package:udschallengeapp/app/modules/create_topic/create_topic_module.dart';
import 'package:udschallengeapp/app/modules/home/home_module.dart';
import 'package:udschallengeapp/app/modules/login/login_module.dart';
import 'package:udschallengeapp/app/modules/recover_password/recover_password_module.dart';
import 'package:udschallengeapp/app/modules/splash/splash_module.dart';
import 'package:udschallengeapp/app/modules/topics/topics_module.dart';

class AppRoutes {
  static const String splash = "/";
  static const String login = "/login";
  static const String createAccount = "/login/create";
  static const String recoverPassword = "/login/recover";
  static const String home = "/home";
  static const String topics = "/topics";
  static const String createTopic = "/topics/create";

  static dynamic get buildRoutes {
    return {
      splash: (_) => SplashModule(),
      login: (_) => LoginModule(),
      createAccount: (_) => CreateAccountModule(),
      recoverPassword: (_) => RecoverPasswordModule(),
      home: (_) => HomeModule(),
      topics: (_) => TopicsModule(),
      createTopic: (_) => CreateTopicModule(),
    };
  }
}
