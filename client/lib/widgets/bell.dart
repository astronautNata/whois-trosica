import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whois_trosica/constants/colors.dart';

class Bell extends StatelessWidget {
  final bool favorited;
  final VoidCallback onClick;
  const Bell({Key? key, required this.favorited, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClick,
      icon: Icon(
        !favorited ? FontAwesomeIcons.bell : FontAwesomeIcons.solidBell,
        color: !favorited ? ColorsHelper.iconColor : ColorsHelper.actionColor,
      ),
    );
  }
}
