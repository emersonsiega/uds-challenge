import 'package:flutter/material.dart';

class TopicsPage extends StatefulWidget {
  final String title;
  const TopicsPage({Key key, this.title = "Topics"}) : super(key: key);

  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
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
