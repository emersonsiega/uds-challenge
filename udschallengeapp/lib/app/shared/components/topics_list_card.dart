import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/components/toaster.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';

class TopicsListCard extends StatelessWidget {
  final String title;
  final int size;
  final void Function() onTap;
  final List<Color> gradientColors;

  TopicsListCard({
    @required this.title,
    @required this.size,
    @required this.onTap,
    @required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: ColorPalette.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                "$size pauta$_plural",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subhead.copyWith(
                      color: ColorPalette.white.withOpacity(0.9),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    if (size == 0) {
      Toaster.showInfo(
        context,
        "Você não possui pautas ${title.toLowerCase()}",
      );
      return;
    }

    onTap();
  }

  String get _plural {
    if (size != 1) {
      return 's';
    }

    return '';
  }
}
