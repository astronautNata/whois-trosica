import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/i18n/strings.g.dart';

class AlertBottomSheet extends StatelessWidget {
  final AsyncCallback turnOn;

  AlertBottomSheet(this.turnOn);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: ColorsHelper.domenTextContainer,
            child: Icon(
              FontAwesomeIcons.bell,
              color: ColorsHelper.darkTextColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            t.turn_remainder,
            style: TextStyle(color: ColorsHelper.darkTextColor, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            //TODO change this
            'Opis obavestenja',
            style: TextStyle(color: ColorsHelper.lightTextColor, fontSize: 13, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: TextButton(
                onPressed: turnOn,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorsHelper.domenTextContainer),
                    minimumSize: MaterialStateProperty.all((Size(double.infinity, 48)))),
                child: Text(
                  t.alert_turn_on,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ColorsHelper.borderColor.withOpacity(0.4)),
                    minimumSize: MaterialStateProperty.all((Size(double.infinity, 48)))),
                child: Text(
                  t.alert_cancel,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: ColorsHelper.iconColor),
                )),
          ),
        ],
      ),
    );
  }
}
