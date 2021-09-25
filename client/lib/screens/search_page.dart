import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:whois_trosica/stores/connectivity_store.dart';
import 'package:whois_trosica/stores/favorites_store.dart';
import 'package:whois_trosica/stores/search_store.dart';
import 'package:whois_trosica/widgets/whois_card.dart';

class SearchPage extends StatefulWidget {
  final searchStore;
  final connectivityStore;
  final favoriteStore;

  SearchPage(this.searchStore, this.connectivityStore, this.favoriteStore,
      {Key? key})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchStore searchStore;
  late ConnectivityStore connStore;
  late FavoritesStore favStore;
  late TextEditingController searchController;
  ReactionDisposer? _disposer;

  @override
  void initState() {
    super.initState();
    searchStore = widget.searchStore;
    connStore = widget.connectivityStore;
    favStore = widget.favoriteStore;
    searchController = TextEditingController(text: searchStore.domen);

    _disposer = reaction<bool>((_) => connStore.isConnected, (connected) {
      if (!connected) {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _disposer!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _handleErrorMessage(),
        _buildSearch(),
        _buildResult(),
      ],
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (searchStore.errorStore.errorMessage.isNotEmpty) {
          Future.delayed(Duration(milliseconds: 0), () {
            FlushbarHelper.createError(
              message: searchStore.errorStore.errorMessage,
              duration: Duration(seconds: 3),
            ).show(context);
          });
        }
        return Container();
      },
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: IntrinsicHeight(
          child: Stack(
            children: [
              _buildSearchForm(),
              _buildNoConnectionIfNeeded(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Enter a domen',
              suffixIcon: IconButton(
                onPressed: () =>
                    searchStore.setDomen(searchController.value.text),
                icon: Icon(Icons.search),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNoConnectionIfNeeded() {
    return Observer(builder: (context) {
      return (!connStore.isConnected)
          ? Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: const Color(0xFF000000).withOpacity(0.3),
                  child: Center(child: Icon(Icons.signal_wifi_off)),
                ),
              ),
            )
          : Container();
    });
  }

  Widget _buildResult() {
    return Expanded(
      child: Observer(builder: (context) {
        var result = searchStore.whois;
        var favorited = false;

        if (result != null) {
          favorited = favStore.containsFavorite(result);
        }
        return Column(
          children: [
            Text('Result'),
            if (!searchStore.isWhoisLoading)
              Expanded(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: Column(
                      children: [
                        if (result != null)
                          WhoisCard(
                            whois: result,
                            favorited: favorited,
                            onFavoriteTap: favorited
                                ? () => favStore.removeFromFavorite(result)
                                : () => favStore.addToFavorite(result),
                          )
                      ],
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              )
          ],
        );
      }),
    );
  }
}
