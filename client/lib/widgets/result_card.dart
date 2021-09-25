import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whois_trosica/constants/colors.dart';

class ResultCardWidget extends StatelessWidget {
  const ResultCardWidget({Key? key}) : super(key: key);

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

    Widget _buildTitle() {
      return Container(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'donesi.rs',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorsHelper.darkTextColor),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.bell,
                      color: ColorsHelper.iconColor,
                    )),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.heart,
                      color: ColorsHelper.iconColor,
                    )),
              ],
            )
          ],
        ),
      );
    }

    Widget _buildSubtitleContent(String title, String subtitle) {
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
              subtitle,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubtitleContent('Vlasnik', 'Zeljko Kosovac'),
                    _buildSubtitleContent('Start', 'long'),
                    _buildSubtitleContent('Name servers', '[ns1,ns2]'),
                    _buildSubtitleContent('dnsRecords', '[r1,r2]'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubtitleContent('Datum registrovanja', '23/10/2020'),
                    _buildSubtitleContent('End', 'long'),
                    _buildSubtitleContent('ipAdress', '[ip1,ip2]'),
                    _buildSubtitleContent('', ''),
                  ],
                )
              ],
            )
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
