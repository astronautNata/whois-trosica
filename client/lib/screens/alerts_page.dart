import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/constants/font.dart';
import 'package:whois_trosica/i18n/strings.g.dart';
import 'package:whois_trosica/stores/alerts_store.dart';
import 'package:whois_trosica/stores/pages_store.dart';
import 'package:whois_trosica/widgets/email_bottom_sheet.dart';
import 'package:whois_trosica/widgets/result_card_small.dart';

class AlertsPage extends StatelessWidget {
  final AlertsStore store;
  final PagesStore pagesStore;
  AlertsPage(this.store, this.pagesStore, {Key? key}) : super(key: key);

  Widget _buildBody(context) {
    return _buildWhoiss(context);
  }

  _showDialog(BuildContext context, String value, Function(String) onOk) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsHelper.bottomSheetOverlayBackground,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: EmailBottomSheet((value) async {
              onOk(value);
              return;
            }, value),
          ),
        );
      },
    );
  }

  Widget _buildWhoiss(context) {
    var media = MediaQuery.of(context);
    return Observer(builder: (context) {
      return Column(
        children: [
          Container(
            color: Colors.white,
            height: media.padding.top,
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 56,
                  width: 56,
                  child: GestureDetector(
                      onTap: () => pagesStore.selectPage(0),
                      child: Icon(Icons.arrow_back)),
                ),
                Text(
                  t.alerts,
                  style: Font.heading1,
                ),
                Container(
                  height: 56,
                  width: 56,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.alert_email,
                      style: Font.caption2
                          .copyWith(color: ColorsHelper.lightTextColor),
                    ),
                    Switch(
                        activeColor: ColorsHelper.actionColor,
                        value: store.emailEnabled,
                        onChanged: (_) {
                          if (!store.emailEnabled) {
                            _showDialog(context, store.email, (value) {
                              Navigator.pop(context);
                              store.setEmail(value);
                              store.toggleEmail();
                            });
                          } else {
                            store.toggleEmail();
                          }
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      t.alert_fb,
                      style: Font.caption2
                          .copyWith(color: ColorsHelper.lightTextColor),
                    ),
                    Switch(
                        activeColor: ColorsHelper.actionColor,
                        value: store.fbEnabled,
                        onChanged: (newValue) {
                          if (!newValue && !store.emailEnabled) {
                            _showDialog(context, store.email, (value) {
                              Navigator.pop(context);
                              store.setEmail(value);
                              store.toggleEmail();
                            });
                          } else {
                            store.toggleFB();
                          }
                        })
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...store.alertsWhoiss
                      .map(
                        (element) => ResultCardSmallWidget(
                          whois: element,
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pagesStore.selectPage(0);
        return false;
      },
      child: _buildBody(context),
    );
  }
}
