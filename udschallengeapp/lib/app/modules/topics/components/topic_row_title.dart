import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';

class TopicRowTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  TopicRowTitle({
    @required this.title,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right: 8,
            ),
            child: Icon(
              icon,
              color: ColorPalette.lightBlue,
              size: 18,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: ColorPalette.lightBlue,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
