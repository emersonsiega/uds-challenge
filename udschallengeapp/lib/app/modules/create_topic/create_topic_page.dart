import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/components/custom_app_bar.dart';

class CreateTopicPage extends StatefulWidget {
  @override
  _CreateTopicPageState createState() => _CreateTopicPageState();
}

class _CreateTopicPageState extends State<CreateTopicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Criar pauta",
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
