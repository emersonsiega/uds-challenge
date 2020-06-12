import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/color_pallete.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  CustomAppBar({
    @required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline.copyWith(
              fontSize: 28,
              color: ColorPallete.black,
              fontWeight: FontWeight.w500,
            ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(65);
}
