import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/modules/topics/components/expandable_topic_tile.dart';
import 'package:udschallengeapp/app/modules/topics/topics_bloc.dart';
import 'package:udschallengeapp/app/modules/topics/topics_module.dart';
import 'package:udschallengeapp/app/shared/blocs/user_topics_bloc.dart';
import 'package:udschallengeapp/app/shared/components/custom_app_bar.dart';
import 'package:udschallengeapp/app/shared/components/loading_action_button.dart';
import 'package:udschallengeapp/app/shared/components/toaster.dart';
import 'package:udschallengeapp/app/shared/exceptions/invalid_request_exception.dart';
import 'package:udschallengeapp/app/shared/model/topic_model.dart';
import 'package:udschallengeapp/app/shared/model/topics_page/topics_page_arguments.dart';
import 'package:udschallengeapp/app/shared/model/topics_page/topics_page_type.dart';

class TopicsPage extends StatefulWidget {
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  final _userTopicsBloc = AppModule.to.bloc<UserTopicsBloc>();
  final _topicsBloc = TopicsModule.to.bloc<TopicsBloc>();

  TopicsPageArguments _pageSettings = TopicsPageArguments();
  TopicModel _selectedTopic;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _init);
  }

  void _init() {
    TopicsPageArguments args = ModalRoute.of(context).settings.arguments;

    setState(() {
      _pageSettings = args;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TopicModel>>(
      stream: _topicStream,
      initialData: [],
      builder: (context, snapshot) {
        return Scaffold(
          appBar: CustomAppBar(
            title: _pageSettings.title,
          ),
          body: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              TopicModel topic = snapshot.data[index];

              return ExpandableTopicTile(
                topic: topic,
                isExpanded: _selectedTopic?.key == topic?.key,
                onTap: (bool expanded) {
                  _onTopicSelected(topic, expanded);
                },
              );
            },
          ),
          floatingActionButton: _selectedTopic == null
              ? null
              : Builder(
                  builder: (context) {
                    if (_opened) {
                      return LoadingActionButton.extended(
                        onPressed: _changeTopicState,
                        icon: Icons.check,
                        tooltip: "Finalizar pauta selecionada",
                        label: "Finalizar",
                        loadingLabel: "Finalizando",
                        isLoading: _isLoading,
                      );
                    } else {
                      return LoadingActionButton.extended(
                        onPressed: _changeTopicState,
                        icon: MdiIcons.packageUp,
                        tooltip: "Reabrir pauta selecionada",
                        label: "Reabrir",
                        loadingLabel: "Reabrindo",
                        isLoading: _isLoading,
                      );
                    }
                  },
                ),
        );
      },
    );
  }

  void _onTopicSelected(TopicModel topic, bool expanded) {
    setState(() {
      if (expanded) {
        _selectedTopic = topic;
      } else {
        _selectedTopic = null;
      }
    });
  }

  bool get _opened => TopicsPageType.opened == _pageSettings.type;

  ValueStream<List<TopicModel>> get _topicStream => _opened
      ? _userTopicsBloc.openedTopicsStream
      : _userTopicsBloc.closedTopicsStream;

  Future<void> _changeTopicState() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await _topicsBloc.changeStatus(_selectedTopic, _opened);

      Future.delayed(Duration.zero, _verifyEmptyList);

      setState(() {
        _selectedTopic = null;
      });
    } on InvalidRequestException catch (ex) {
      Toaster.showError(context, ex.cause);
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _verifyEmptyList() {
    if (_topicStream.value.isEmpty) {
      Navigator.of(context).pop(
        "Todas as pautas foram ${_opened ? "finalizadas" : "reabertas"}",
      );
    }
  }
}
