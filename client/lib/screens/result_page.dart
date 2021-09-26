import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:whois_trosica/constants/assets.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/i18n/strings.g.dart';
import 'package:whois_trosica/stores/pages_store.dart';
import 'package:whois_trosica/stores/search_store.dart';
import 'package:whois_trosica/widgets/result_card.dart';

class ResultPage extends StatefulWidget {
  final SearchStore store;
  final PagesStore pages;
  const ResultPage({Key? key, required this.store, required this.pages})
      : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Widget _buildAppBar(SearchStore store) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1, color: ColorsHelper.borderColor))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.search,
                color: ColorsHelper.iconColor,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                store.domen ?? '',
                style: TextStyle(
                    color: ColorsHelper.darkTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.store.setErrorVisibillity(false);
              },
              icon: Icon(
                FontAwesomeIcons.times,
                color: ColorsHelper.iconColor,
              )),
        ],
      ),
    );
  }

  Widget _buildDomenTitle(SearchStore store) {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            color: ColorsHelper.domenTextContainer,
            child: Text(
              store.domen ?? '',
              style: TextStyle(
                color: ColorsHelper.darkTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          if (store.errorStore.errorMessage.isEmpty)
            Text(
              t.domain_found,
              style: TextStyle(
                color: ColorsHelper.lightTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (store.errorStore.errorMessage.isNotEmpty)
            Text(
              t.domain_not_found,
              style: TextStyle(
                color: ColorsHelper.lightTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var error = widget.store.errorStore.errorMessage.isNotEmpty;

    return Observer(
      builder: (context) {
        return Scaffold(
          body: Container(
            color: ColorsHelper.backgroundColor,
            child: SingleChildScrollView(
                child: Column(children: [
              Container(color: Colors.white, height: media.padding.top),
              _buildAppBar(widget.store),
              if (error) const SizedBox(height: 80),
              _buildDomenTitle(widget.store),
              if (!error && widget.store.whois != null)
                ResultCardWidget(
                  whois: widget.store.whois!,
                  favClicked: () {},
                ),
              if (error)
                Container(
                  transform: Matrix4.translationValues(0.0, -160.0, 0.0),
                  child: Transform.scale(
                    scale: 1.8,
                    child: Lottie.asset(
                      Assets.error,
                      repeat: false,
                      width: double.infinity,
                      height: 500,
                    ),
                  ),
                ),
            ])),
          ),
        );
      },
    );
  }
}
