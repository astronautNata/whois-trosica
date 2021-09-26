import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';
import 'package:whois_trosica/stores/alerts_store.dart';
import 'package:whois_trosica/widgets/bell.dart';

class ResultCardSmallWidget extends StatefulWidget {
  final WhoisResponse whois;
  const ResultCardSmallWidget({Key? key, required this.whois})
      : super(key: key);

  @override
  _ResultCardSmallWidgetState createState() => _ResultCardSmallWidgetState();
}

class _ResultCardSmallWidgetState extends State<ResultCardSmallWidget> {
  bool rawOpened = false;

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        var alertsStore = Provider.of<AlertsStore>(context);
        if (alertsStore.errorStore.errorMessage.isNotEmpty) {
          Future.delayed(Duration(milliseconds: 0), () {
            FlushbarHelper.createError(
              message: alertsStore.errorStore.errorMessage,
              duration: Duration(seconds: 3),
            ).show(context);
            alertsStore.errorStore.reset();
          });
        }
        return Container();
      },
    );
  }

  Widget _buildTitle() {
    return Observer(
      builder: (context) {
        var alertsStore = Provider.of<AlertsStore>(context);
        var alertExist = alertsStore.containsAlerts(widget.whois);

        return Container(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.whois.domen ?? '',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorsHelper.darkTextColor),
              ),
              Row(
                children: [
                  Bell(
                    onClick: () {
                      alertsStore.toggleAlerts(widget.whois);
                    },
                    favorited: alertExist,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_buildTitle(), _handleErrorMessage()],
          ),
        ),
        SizedBox(height: 16)
      ],
    );
  }
}
