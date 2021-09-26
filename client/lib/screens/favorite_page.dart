import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:whois_trosica/constants/font.dart';
import 'package:whois_trosica/i18n/strings.g.dart';
import 'package:whois_trosica/stores/favorites_store.dart';
import 'package:whois_trosica/stores/pages_store.dart';
import 'package:whois_trosica/widgets/result_card.dart';

class FavoritePage extends StatelessWidget {
  final FavoritesStore store;
  final PagesStore pagesStore;
  const FavoritePage(this.store, this.pagesStore, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(child: _buildWhoiss(context));
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
                  child: GestureDetector(onTap: () => pagesStore.selectPage(0), child: Icon(Icons.arrow_back)),
                ),
                Text(
                  t.favorite_domains,
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
          SingleChildScrollView(
            child: Column(
              children: [
                ...store.favoriteWhoiss
                    .map(
                      (element) => ResultCardWidget(
                        whois: element,
                        favClicked: () {
                          store.toggleFavorite(element);
                        },
                      ),
                    )
                    .toList()
              ],
            ),
          )
        ],
      );
    });
  }
}
