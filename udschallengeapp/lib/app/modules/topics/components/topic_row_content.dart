import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';

class TopicRowContent extends StatelessWidget {
  final String text;
  final TextStyle style;

  ///
  /// Default [style] is subhead.
  ///
  TopicRowContent({
    @required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            text,
            style: (style ?? Theme.of(context).textTheme.subhead).copyWith(
              color: ColorPalette.black,
            ),
          ),
        ),
      ],
    );
  }
}
