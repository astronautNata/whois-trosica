import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/i18n/strings.g.dart';

class EmailBottomSheet extends StatefulWidget {
  final Function(String) turnOn;
  final TextEditingController controller;

  EmailBottomSheet(this.turnOn, String value)
      : controller = TextEditingController(text: value);

  @override
  _EmailBottomSheetState createState() => _EmailBottomSheetState();
}

class _EmailBottomSheetState extends State<EmailBottomSheet> {
  String? error;

  void onSubmit() {
    final value = widget.controller.value.text;
    final valid = EmailValidator.validate(value);

    if (valid) {
      setState(() {
        error = null;
      });
      widget.turnOn(widget.controller.text);
    } else {
      setState(() {
        error = t.email_not_valid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: ColorsHelper.domenTextContainer,
            child: Icon(
              FontAwesomeIcons.mailBulk,
              color: ColorsHelper.darkTextColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            t.email_enter,
            style: TextStyle(
                color: ColorsHelper.darkTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: widget.controller,
              onEditingComplete: onSubmit,
              decoration: InputDecoration(
                labelText: t.email_enter,
                errorText: error == null || error!.isEmpty ? null : error,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: TextButton(
              onPressed: onSubmit,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ColorsHelper.actionColor),
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 48)),
              ),
              child: Text(
                t.email_accept,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        ColorsHelper.borderColor.withOpacity(0.4)),
                    minimumSize:
                        MaterialStateProperty.all((Size(double.infinity, 48)))),
                child: Text(
                  t.alert_cancel,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: ColorsHelper.iconColor),
                )),
          ),
        ],
      ),
    );
  }
}
