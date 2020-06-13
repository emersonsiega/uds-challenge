import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/modules/home/components/user_profile_widget.dart';
import 'package:udschallengeapp/app/modules/home/home_bloc.dart';
import 'package:udschallengeapp/app/modules/home/home_module.dart';
import 'package:udschallengeapp/app/shared/blocs/user_topics_bloc.dart';
import 'package:udschallengeapp/app/shared/components/custom_app_bar.dart';
import 'package:udschallengeapp/app/shared/components/loading_action_button.dart';
import 'package:udschallengeapp/app/shared/components/toaster.dart';
import 'package:udschallengeapp/app/shared/components/topics_list_card.dart';
import 'package:udschallengeapp/app/shared/config/app_routes.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/topic_model.dart';
import 'package:udschallengeapp/app/shared/model/topics_page/topics_page_arguments.dart';
import 'package:udschallengeapp/app/shared/model/topics_page/topics_page_type.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = HomeModule.to.bloc<HomeBloc>();
  final _userTopicsBloc = AppModule.to.bloc<UserTopicsBloc>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _loadData);
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    await _loadUserData();

    _userTopicsBloc.loadTopics();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadUserData() async {
    try {
      await _homeBloc.loadUserData();
    } on InvalidRequestException catch (ex) {
      Toaster.showError(context, ex.cause);

      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      });
    }
  }

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
              iconSize: 40,
              onPressed: _onAccountPressed,
              tooltip: "Perfil do usuário",
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<List<TopicModel>>(
              stream: _userTopicsBloc.openedTopicsStream,
              initialData: [],
              builder: (context, snapshot) {
                return Flexible(
                  flex: 5,
                  child: TopicsListCard(
                    title: "ABERTAS",
                    size: snapshot.data.length,
                    gradientColors: [
                      ColorPalette.udsBlue,
                      ColorPalette.lightBlue,
                    ],
                    onTap: () => _showTopics(
                      "Pautas abertas",
                      TopicsPageType.opened,
                    ),
                  ),
                );
              },
            ),
            StreamBuilder<List<TopicModel>>(
              stream: _userTopicsBloc.closedTopicsStream,
              initialData: [],
              builder: (context, snapshot) {
                return Flexible(
                  flex: 5,
                  child: TopicsListCard(
                    title: "FINALIZADAS",
                    size: snapshot.data.length,
                    gradientColors: [
                      ColorPalette.black2,
                      ColorPalette.grey,
                    ],
                    onTap: () => _showTopics(
                      "Pautas finalizadas",
                      TopicsPageType.closed,
                    ),
                  ),
                );
              },
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
      floatingActionButton: LoadingActionButton(
        icon: Icons.add,
        onPressed: _isLoading ? null : _createTopic,
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

  void _showTopics(String title, TopicsPageType type) {
    Navigator.of(context)
        .pushNamed(
          AppRoutes.topics,
          arguments: TopicsPageArguments(title: title, type: type),
        )
        .then(_showTopicsMessage);
  }

  void _showTopicsMessage(dynamic message) {
    if (message != null) {
      Toaster.showInfo(context, message);
    }
  }

  Future<void> _createTopic() async {
    Navigator.of(context).pushNamed(AppRoutes.createTopic);
  }

  Future<void> _logout() async {
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    await _homeBloc.logout();
  }
}
