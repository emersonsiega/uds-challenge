import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:udschallengeapp/app/app_module.dart';
import 'package:udschallengeapp/app/shared/blocs/user_session_bloc.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';

class UserProfileWidget extends StatelessWidget {
  final Function onLogOut;
  final _userSessionBloc = AppModule.to.bloc<UserSessionBloc>();

  UserProfileWidget({
    @required this.onLogOut,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: 0.1,
            child: Container(
              height: 5,
              margin: EdgeInsets.only(top: 15, bottom: 30),
              decoration: BoxDecoration(
                color: ColorPalette.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          ShaderMask(
            shaderCallback: (bounds) => RadialGradient(
              colors: [
                ColorPalette.black,
                ColorPalette.grey,
              ],
              center: Alignment.topLeft,
              radius: 0.4,
              tileMode: TileMode.mirror,
            ).createShader(bounds),
            child: Icon(
              MdiIcons.accountCircle,
              size: 80,
              color: ColorPalette.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Text(
              _userSessionBloc.userStream?.value?.name ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline.copyWith(
                    color: ColorPalette.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              _userSessionBloc.userStream?.value?.email ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subhead.copyWith(
                    color: ColorPalette.black,
                  ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onLogOut();
                  },
                  child: Text(
                    "SAIR",
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: ColorPalette.udsBlue,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
