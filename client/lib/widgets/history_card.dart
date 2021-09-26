import 'package:flutter/material.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/constants/font.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';

class HistoryCard extends StatelessWidget {
  final WhoisResponse whois;
  final VoidCallback? onClick;

  const HistoryCard({
    Key? key,
    required this.whois,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 32, bottom: 19, top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.history,
            color: ColorsHelper.historyColor,
          ),
          const SizedBox(width: 12),
          Text(
            whois.domen ?? '',
            style: Font.caption2
                .copyWith(color: ColorsHelper.iconColor.withOpacity(0.7)),
          ),
          Spacer(),
          Transform.rotate(
            angle: 0.9,
            child: GestureDetector(
              onTap: onClick,
              child: Icon(
                Icons.arrow_upward_outlined,
                color: ColorsHelper.iconColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
