import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:whois_trosica/stores/favorites_store.dart';
import 'package:whois_trosica/widgets/whois_card.dart';

class FavoritePage extends StatelessWidget {
  final FavoritesStore store;
  const FavoritePage(this.store, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return SingleChildScrollView(child: _buildWhoiss());
  }

  Widget _buildWhoiss() {
    return Observer(builder: (context) {
      return Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ...store.favoriteWhoiss
                    .map((element) => WhoisCard(
                          whois: element,
                          favorited: true,
                          onFavoriteTap: () =>
                              store.removeFromFavorite(element),
                        ))
                    .toList()
              ],
            ),
          )
        ],
      );
    });
  }
}
