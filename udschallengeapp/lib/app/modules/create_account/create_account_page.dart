import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  final String title;
  const CreateAccountPage({Key key, this.title = "CreateAccount"})
      : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
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
