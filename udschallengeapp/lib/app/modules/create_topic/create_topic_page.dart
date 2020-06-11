import 'package:flutter/material.dart';

class CreateTopicPage extends StatefulWidget {
  final String title;
  const CreateTopicPage({Key key, this.title = "CreateTopic"})
      : super(key: key);

  @override
  _CreateTopicPageState createState() => _CreateTopicPageState();
}

class _CreateTopicPageState extends State<CreateTopicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
