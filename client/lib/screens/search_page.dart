import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:whois_trosica/animations/router_animation.dart';
import 'package:whois_trosica/constants/assets.dart';
import 'package:whois_trosica/constants/colors.dart';
import 'package:whois_trosica/constants/domain_regex.dart';
import 'package:whois_trosica/constants/enums.dart';
import 'package:whois_trosica/constants/font.dart';
import 'package:whois_trosica/i18n/strings.g.dart';
import 'package:whois_trosica/screens/result_page.dart';
import 'package:whois_trosica/services/localization.dart';
import 'package:whois_trosica/stores/connectivity_store.dart';
import 'package:whois_trosica/stores/favorites_store.dart';
import 'package:whois_trosica/stores/history_store.dart';
import 'package:whois_trosica/stores/language_store.dart';
import 'package:whois_trosica/stores/pages_store.dart';
import 'package:whois_trosica/stores/search_store.dart';
import 'package:whois_trosica/widgets/history_card.dart';
import 'package:whois_trosica/widgets/locale_dropdown.dart';
import 'package:whois_trosica/widgets/search_box.dart';

class SearchPage extends StatefulWidget {
  final searchStore;
  final connectivityStore;
  final favoriteStore;
  final historyStore;
  final languageStore;
  final pagesStore;

  SearchPage(this.searchStore, this.connectivityStore, this.favoriteStore,
      this.historyStore, this.languageStore, this.pagesStore,
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
  late LanguageStore languageStore;
  late PagesStore pagesStore;
  late TextEditingController searchController;
  ReactionDisposer? _disposer;

  @override
  void initState() {
    super.initState();
    searchStore = widget.searchStore;
    connStore = widget.connectivityStore;
    favStore = widget.favoriteStore;
    historyStore = widget.historyStore;
    languageStore = widget.languageStore;
    pagesStore = widget.pagesStore;
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

  Widget _showLoadingOverlay() {
    return Stack(
      children: [
        SizedBox.expand(
          child: Container(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        Center(
          child: CircularProgressIndicator(
            color: ColorsHelper.actionColor,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 10),
        child: Row(
          children: [
            LocaleDropDown(
              onLocaleChange: (value) {
                languageStore.changeLanguage(value);
                LocaleSettings.setLocale(
                    LocalizationPicker.returnAppLocale(languageStore.locale));
              },
              curentValue: languageStore.locale,
            ),
            Spacer(),
            Container(
              height: 56,
              width: 56,
              child: Icon(
                FontAwesomeIcons.bell,
                color: ColorsHelper.iconColor,
                size: 24,
              ),
            ),
            Container(
              height: 56,
              width: 56,
              child: GestureDetector(
                onTap: () => pagesStore.selectPage(Pages.Favorite.index),
                child: Icon(
                  FontAwesomeIcons.heart,
                  color: ColorsHelper.iconColor,
                  size: 24,
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildDescription() {
    final t = Translations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t.home_title1,
          style: Font.heading1.copyWith(color: ColorsHelper.lightTextColor),
        ),
        Container(
          padding: EdgeInsets.all(4),
          color: ColorsHelper.greenBackground,
          child: Text(
            t.home_title2,
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

  Widget _buildNotValidDomainError() {
    return Observer(
      builder: (context) {
        return Visibility(
          visible: searchStore.isErrorVisible!,
          child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 20.0, bottom: 25),
              child: Text(
                'Not a valid domain!',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
                textAlign: TextAlign.left,
              )),
        );
      },
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
          const EdgeInsets.only(left: 19.0, right: 19, top: 26, bottom: 10),
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
      child: SearchBox(
        (value) async {
          if (!Domain.isValid(value)) {
            searchStore.setErrorVisibillity(true);
            return;
          }
          await searchStore.setDomen(value);
          await Navigator.of(context).push(
            RouterAnimator.animateRoute(
              () => ResultPage(
                pages: pagesStore,
                store: searchStore,
              ),
            ),
          );
        },
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
                  padding: EdgeInsets.only(right: 16),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.signal_wifi_off),
                ),
              ),
            )
          : Container();
    });
  }

  Widget _buildHistory() {
    final t = Translations.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              t.home_last_search,
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
                return HistoryCard(
                  whois: historyStore.historyWhoiss[index],
                  onClick: () async {
                    await searchStore
                        .setDomen(historyStore.historyWhoiss[index].domen!);
                    pagesStore.selectPage(Pages.Result.index);
                  },
                );
              },
            );
          })),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                _buildAnimation(),
                _buildDescription(),
                _buildSearch(),
                _buildNotValidDomainError(),
                _buildHistory(),
              ],
            ),
            Observer(builder: (context) {
              if (searchStore.isWhoisLoading) {
                return _showLoadingOverlay();
              }

              return Container();
            })
          ],
        ),
      ),
    );
  }
}
