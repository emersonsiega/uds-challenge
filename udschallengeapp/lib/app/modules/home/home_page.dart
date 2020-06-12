import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/modules/home/components/user_profile_widget.dart';
import 'package:udschallengeapp/app/shared/components/custom_app_bar.dart';
import 'package:udschallengeapp/app/shared/components/loading_action_button.dart';
import 'package:udschallengeapp/app/shared/config/app_routes.dart';
import 'package:udschallengeapp/app/shared/config/color_pallete.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Pautas",
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 36,
              onPressed: _onAccountPressed,
              tooltip: "Perfil do usuário",
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Você não possui nenhuma pauta criada.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subhead.copyWith(
                color: ColorPallete.black,
              ),
        ),
      ),
      floatingActionButton: LoadingActionButton(
        icon: Icons.add,
        onPressed: _createTopic,
        tooltip: "Criar pauta",
      ),
    );
  }

  void _onAccountPressed() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isDismissible: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return UserProfileWidget(
          onLogOut: _logout,
        );
      },
    );
  }

  Future<void> _createTopic() async {
    Navigator.of(context).pushNamed(AppRoutes.createTopic);
  }

  Future<void> _logout() async {
    //TODO: Temporary...
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }
}
