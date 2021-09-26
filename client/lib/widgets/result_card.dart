import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/i18n/strings.g.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';
import 'package:whois_trosica/stores/alerts_store.dart';
import 'package:whois_trosica/stores/favorites_store.dart';
import 'package:whois_trosica/widgets/alert_bottom_sheet.dart';
import 'package:whois_trosica/widgets/bell.dart';
import 'package:whois_trosica/widgets/heart.dart';

class ResultCardWidget extends StatefulWidget {
  final WhoisResponse whois;
  const ResultCardWidget({Key? key, required this.whois}) : super(key: key);

  @override
  _ResultCardWidgetState createState() => _ResultCardWidgetState();
}

class _ResultCardWidgetState extends State<ResultCardWidget> {
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

  Widget _buildDivider() {
    return Divider(
      color: ColorsHelper.dividerColor,
      thickness: 1,
    );
  }

  Widget _buildTitle() {
    return Observer(
      builder: (context) {
        var favoriteStore = Provider.of<FavoritesStore>(context);
        var alertsStore = Provider.of<AlertsStore>(context);
        var favorited = favoriteStore.containsFavorite(widget.whois);
        var alertExist = alertsStore.containsAlerts(widget.whois);

        return Container(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
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
                    onClick: !alertExist
                        ? () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor:
                                  ColorsHelper.bottomSheetOverlayBackground,
                              builder: (context) {
                                return AlertBottomSheet(() async {
                                  await alertsStore.toggleAlerts(widget.whois);
                                  favoriteStore.addToFavorite(widget.whois);
                                  Navigator.of(context).pop();

                                  return;
                                });
                              },
                            );
                          }
                        : () => alertsStore.toggleAlerts(widget.whois),
                    favorited: alertExist,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Heart(
                    favorited: favorited,
                    onClick: () => favoriteStore.toggleFavorite(widget.whois),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubtitleContent(String title, String? subtitle,
      [bool showDivider = true]) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ColorsHelper.iconColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  subtitle ?? '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ColorsHelper.darkTextColor,
                  ),
                )
              ],
            ),
          ),
          if (showDivider) const SizedBox(height: 16),
          if (showDivider)
            Container(
              color: ColorsHelper.dividerColor,
              height: 1,
              width: double.infinity,
            ),
        ],
      ),
    );
  }

  Widget _buildRawResponseMenu() {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
      color: ColorsHelper.borderColor.withOpacity(0.6),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.raw_result,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ColorsHelper.iconColor,
                  ),
                ),
                Spacer(),
                if (rawOpened)
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.whois.completeInfo));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(t.copied)));
                    },
                    child: Icon(
                      Icons.copy,
                      color: ColorsHelper.iconColor,
                    ),
                  ),
                if (rawOpened) SizedBox(width: 18),
                if (rawOpened)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        rawOpened = false;
                      });
                    },
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: ColorsHelper.iconColor,
                    ),
                  ),
                if (!rawOpened)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        rawOpened = true;
                      });
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorsHelper.iconColor,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRawResponse() {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 20),
      color: ColorsHelper.borderColor.withOpacity(0.3),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Text(
              widget.whois.completeInfo ?? '',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: ColorsHelper.iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSubtitleContent(t.domain_owner, widget.whois.owner),
          _buildSubtitleContent(
              t.registration_date, widget.whois.registrationDate.toString()),
          _buildSubtitleContent(
              t.expiration_date, widget.whois.expirationDate.toString()),
          _buildSubtitleContent(
              'Name servers',
              widget.whois.nameservers
                  ?.fold<String>(
                      '',
                      (previousValue, element) =>
                          '$previousValue\n${element.trim()}')
                  .trim(),
              false),
          _buildRawResponseMenu(),
          if (rawOpened) _buildRawResponse()
        ],
      ),
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
            children: [
              _buildTitle(),
              _buildDivider(),
              _buildContent(),
              _handleErrorMessage()
            ],
          ),
        ),
        SizedBox(height: 16)
      ],
    );
  }
}
