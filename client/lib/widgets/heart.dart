import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whois_trosica/constants/colors.dart';

class Heart extends StatelessWidget {
  final bool favorited;
  final VoidCallback onClick;
  const Heart({Key? key, required this.favorited, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClick,
      icon: Icon(
        !favorited ? FontAwesomeIcons.heart : FontAwesomeIcons.solidHeart,
        color: !favorited ? ColorsHelper.iconColor : ColorsHelper.actionColor,
      ),
    );
  }
}
