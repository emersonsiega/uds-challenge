import 'package:flutter/material.dart';
import 'package:udschallengeapp/app/shared/config/color_palette.dart';

///
/// FloatingActionButton wrapper, with an internal CircularProgressIndicator
/// displayed when [isLoading] is true.
///
class LoadingActionButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isLoading;
  final IconData icon;
  final String tooltip;

  LoadingActionButton({
    @required this.onPressed,
    @required this.icon,
    this.isLoading: false,
    this.tooltip: "",
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onPressed,
      tooltip: tooltip,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 250),
        child: isLoading
            ? CircularProgressIndicator(
                key: Key("loading"),
                strokeWidth: 1.5,
                valueColor: AlwaysStoppedAnimation(ColorPalette.white),
              )
            : Icon(
                icon,
                key: Key("stoped"),
              ),
      ),
    );
  }

  ///
  /// Call onPressed only when it's not loading
  ///
  void _onPressed() {
    if (isLoading) {
      return;
    }

    onPressed();
  }
}
