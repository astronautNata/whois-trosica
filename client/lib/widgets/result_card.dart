import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/i18n/strings.g.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';
import 'package:whois_trosica/stores/favorites_store.dart';
import 'package:whois_trosica/widgets/alert_bottom_sheet.dart';
import 'package:whois_trosica/widgets/heart.dart';

class ResultCardWidget extends StatelessWidget {
  final WhoisResponse whois;
  final VoidCallback favClicked;
  const ResultCardWidget({Key? key, required this.whois, required this.favClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildDivider() {
      return Divider(
        color: ColorsHelper.dividerColor,
        thickness: 1,
        height: 30,
        indent: 20,
        endIndent: 20,
      );
    }

    Future<void> onAlertTurn() async {}

    Widget _buildTitle() {
      return Observer(
        builder: (context) {
          var favoriteStore = Provider.of<FavoritesStore>(context);
          var favorited = favoriteStore.containsFavorite(whois);
          return Container(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  whois.domen ?? '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorsHelper.darkTextColor),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: ColorsHelper.bottomSheetOverlayBackground,
                            builder: (context) {
                              return AlertBottomSheet(onAlertTurn);
                            },
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.bell,
                          color: ColorsHelper.iconColor,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Heart(
                      favorited: favorited,
                      onClick: () => favoriteStore.toggleFavorite(whois),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    Widget _buildSubtitleContent(String title, String? subtitle) {
      return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style:
                  TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ColorsHelper.iconColor.withOpacity(0.7)),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              subtitle ?? '',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ColorsHelper.darkTextColor),
            )
          ],
        ),
      );
    }

    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.fromLTRB(30, 10, 60, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSubtitleContent(t.domain_owner, whois.owner),
                      _buildSubtitleContent(t.registration_date, whois.registrationDate.toString()),
                      _buildSubtitleContent(t.expiration_date, whois.expirationDate.toString()),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSubtitleContent(
                          'Name servers',
                          whois.nameservers
                              ?.fold<String>('', (previousValue, element) => '$previousValue\n${element.trim()}')
                              .trim())
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTitle(),
          _buildDivider(),
          _buildContent(),
        ],
      ),
    );
  }
}
