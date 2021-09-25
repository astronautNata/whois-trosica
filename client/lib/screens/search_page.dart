import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:whois_trosica/constants/assets.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/constants/font.dart';
import 'package:whois_trosica/stores/connectivity_store.dart';
import 'package:whois_trosica/stores/favorites_store.dart';
import 'package:whois_trosica/stores/history_store.dart';
import 'package:whois_trosica/stores/search_store.dart';
import 'package:whois_trosica/widgets/history_card.dart';
import 'package:whois_trosica/widgets/search_box.dart';

class SearchPage extends StatefulWidget {
  final searchStore;
  final connectivityStore;
  final favoriteStore;
  final historyStore;

  SearchPage(this.searchStore, this.connectivityStore, this.favoriteStore,
      this.historyStore,
      {Key? key})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  late SearchStore searchStore;
  late HistoryStore historyStore;
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
    historyStore = widget.historyStore;
    searchController = TextEditingController(text: searchStore.domen);

    _disposer = reaction<bool>((_) => connStore.isConnected, (connected) {
      if (!connected) {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }
    });

    var _listener;
    _listener = () {
      if (_controller.status == AnimationStatus.completed) {
        // _controller.repeat(
        //   min: 0.4,
        //   max: 1,
        //   reverse: true,
        //   period: _controller.duration! * (1 - 0.4),
        // );
        // _controller.removeListener(_listener);
        // setState(() {});
      }
    };

    _controller = AnimationController(vsync: this);
    _controller.addListener(_listener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _disposer!();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimation(),
        _buildDescription(),
        _buildSearch(),
        _buildHistory(),
      ],
    );
  }

  Widget _buildDescription() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Pretrazi i upravljaj ',
          style: Font.heading1.copyWith(color: ColorsHelper.lightTextColor),
        ),
        Container(
          padding: EdgeInsets.all(4),
          color: ColorsHelper.greenBackground,
          child: Text(
            'domacim domenima',
            style: Font.heading1.copyWith(color: ColorsHelper.darkTextColor),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimation() {
    return Container(
      padding: EdgeInsets.only(top: 24, right: 97, left: 97, bottom: 34),
      child: Lottie.asset(
        Assets.domain,
        repeat: false,
        controller: _controller,
        onLoaded: (composition) {
          setState(() {
            _controller.duration = composition.duration;
            _controller.forward();
          });
        },
      ),
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
      padding:
          const EdgeInsets.only(left: 19.0, right: 19, top: 26, bottom: 25),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            _buildSearchForm(),
            _buildNoConnectionIfNeeded(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchForm() {
    return Container(
      child: SearchBox((value) => searchStore.setDomen(value)),
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

  Widget _buildHistory() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'POSLEDNJE PRETRAGE',
              style: Font.caption3.copyWith(color: ColorsHelper.iconColor),
            ),
          ),
          Expanded(child: Observer(builder: (context) {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Container(
                color: ColorsHelper.dividerColor,
                height: 1,
                width: double.infinity,
              ),
              itemCount: historyStore.historyWhoiss.length,
              itemBuilder: (context, index) {
                return HistoryCard(whois: historyStore.historyWhoiss[index]);
              },
            );
          })),
        ],
      ),
    );
  }
}
