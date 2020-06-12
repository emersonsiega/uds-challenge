import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/color_pallete.dart';

class CreateTopicPage extends StatefulWidget {
  @override
  _CreateTopicPageState createState() => _CreateTopicPageState();
}

class _CreateTopicPageState extends State<CreateTopicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Criar pauta",
          style: Theme.of(context).textTheme.headline.copyWith(
                color: ColorPallete.black,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
