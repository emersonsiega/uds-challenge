import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/color_pallete.dart';

class UserProfileWidget extends StatelessWidget {
  final Function onLogOut;

  UserProfileWidget({
    @required this.onLogOut,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 5,
                width: 30,
                margin: EdgeInsets.only(top: 15, bottom: 30),
                decoration: BoxDecoration(
                  color: ColorPallete.black.withAlpha(80),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    child: OutlineButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onLogOut();
                      },
                      child: Text(
                        "SAIR",
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: ColorPallete.udsBlue,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
