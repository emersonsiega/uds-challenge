import 'package:flutter/material.dart';

class RecoverPasswordPage extends StatefulWidget {
  final String title;
  const RecoverPasswordPage({Key key, this.title = "RecoverPassword"})
      : super(key: key);

  @override
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
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
