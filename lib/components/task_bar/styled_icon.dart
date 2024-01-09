import 'package:flutter/material.dart';
import 'package:wallet/app/styles.dart';

class StyledIcon extends StatelessWidget {
  const StyledIcon(this.icon, {super.key});
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: Styles.iconSize,
      color: Styles.toolbarForegroundColor,
      shadows: const [Shadow(color: Styles.toolbarShadowColor, blurRadius: 10)],
    );
  }
}
