import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/constants/enums.dart';
import 'package:whois_trosica/services/localization.dart';

class LocaleDropDown extends StatefulWidget {
  final Function(Locales) onLocaleChange;
  final Locales curentValue;
  const LocaleDropDown(
      {required this.onLocaleChange, required this.curentValue, Key? key})
      : super(key: key);

  @override
  _LocaleDropDownState createState() => _LocaleDropDownState();
}

class _LocaleDropDownState extends State<LocaleDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: ColorsHelper.iconColor.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.fromLTRB(18, 12, 18, 12),
              child: PopupMenuButton<Locales>(
                itemBuilder: (context) {
                  return Locales.values.map((locale) {
                    return PopupMenuItem(
                      value: locale,
                      child: Text(
                        LocalizationPicker.displayValue(locale),
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: ColorsHelper.iconColor),
                      ),
                    );
                  }).toList();
                },
                onSelected: widget.onLocaleChange,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      LocalizationPicker.displayValue(widget.curentValue),
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: ColorsHelper.iconColor),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      FontAwesomeIcons.chevronDown,
                      color: ColorsHelper.iconColor.withOpacity(0.5),
                      size: 10,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
