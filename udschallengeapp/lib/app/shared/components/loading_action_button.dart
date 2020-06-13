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
  final FloatingActionButton _child;

  LoadingActionButton({
    @required this.onPressed,
    @required this.icon,
    this.isLoading: false,
    this.tooltip: "",
  }) : this._child = FloatingActionButton(
          onPressed: () {
            if (isLoading) {
              return;
            }

            onPressed();
          },
          tooltip: tooltip,
          child: _LoadingAnimatedSwitcher(
            isLoading: isLoading,
            icon: icon,
          ),
        );

  ///
  /// Extended option, that shows an icon with label. The icon is animated
  /// when [isLoading] changes.
  ///
  LoadingActionButton.extended({
    @required this.onPressed,
    @required this.icon,
    @required String label,
    String loadingLabel: "Aguarde",
    this.tooltip: "",
    this.isLoading: false,
  }) : this._child = FloatingActionButton.extended(
          onPressed: () {
            if (isLoading) {
              return;
            }

            onPressed();
          },
          tooltip: tooltip,
          label: Text(isLoading ? loadingLabel : label),
          icon: _LoadingAnimatedSwitcher(
            isLoading: isLoading,
            icon: icon,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}

class _LoadingAnimatedSwitcher extends StatelessWidget {
  final bool isLoading;
  final IconData icon;

  _LoadingAnimatedSwitcher({
    @required this.isLoading,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
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
    );
  }
}
