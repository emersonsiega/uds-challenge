import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/components/custom_app_bar.dart';
import 'package:udschallengeapp/app/shared/model/topics_page/topics_page_arguments.dart';

class TopicsPage extends StatefulWidget {
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  TopicsPageArguments _pageSettings = TopicsPageArguments();

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
    return Scaffold(
      appBar: CustomAppBar(
        title: _pageSettings.title,
      ),
      body: Container(),
    );
  }
}
