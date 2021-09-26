import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_trosica/constants/enums.dart';
import 'package:whois_trosica/i18n/strings.g.dart';
import 'package:whois_trosica/screens/favorite_page.dart';
import 'package:whois_trosica/screens/history_page.dart';
import 'package:whois_trosica/screens/result_page.dart';
import 'package:whois_trosica/screens/search_page.dart';
import 'package:whois_trosica/services/localization.dart';
import 'package:whois_trosica/services/sharedpreferences.dart';
import 'package:whois_trosica/stores/connectivity_store.dart';
import 'package:whois_trosica/stores/favorites_store.dart';
import 'package:whois_trosica/stores/history_store.dart';
import 'package:whois_trosica/stores/language_store.dart';
import 'package:whois_trosica/stores/pages_store.dart';
import 'package:whois_trosica/stores/search_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  setPreferedOrientation();
  runApp(TranslationProvider(child: MyApp(sharedPreferences)));
}

void setPreferedOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final _pagesStore = PagesStore();

  MyApp(this.sharedPreferences, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferencesService>(
          create: (_) => PreferencesService(sharedPreferences),
        ),
        Provider<PagesStore>(
          create: (_) => _pagesStore,
        ),
        ProxyProvider<PreferencesService, LanguageStore>(
            update: (_, preferencesService, __) =>
                LanguageStore(preferencesService)),
        Provider<ConnectivityStore>(
          create: (_) => ConnectivityStore(),
        ),
        ProxyProvider<PreferencesService, FavoritesStore>(
            update: (_, preferencesService, __) =>
                FavoritesStore(preferencesService)),
        ProxyProvider<PreferencesService, HistoryStore>(
            update: (_, preferencesService, __) =>
                HistoryStore(preferencesService)),
        ProxyProvider<HistoryStore, SearchStore>(
            update: (_, historyStore, __) => SearchStore(historyStore)),
      ],
      child: Consumer<LanguageStore>(builder: (_, languageStore, __) {
        return Observer(
          builder: (context) {
            return MaterialApp(
              title: 'whoisTrosica',
              theme: ThemeData(primarySwatch: Colors.blue),
              debugShowCheckedModeBanner: false,
              supportedLocales: languageStore.supportedLanguages,
              locale: LocalizationPicker.returnLocale(languageStore.locale),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: Observer(
                builder: (_) => Scaffold(
                  body: PageContainer(_pagesStore.selectedDestination),
                  //bottomNavigationBar: AppBottomNavigationBar(_pagesStore),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class AppBottomNavigationBar extends StatelessWidget {
  final PagesStore store;

  const AppBottomNavigationBar(
    this.store, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: const Key('bottomNavigationBar'),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: store.selectedDestinationIndex,
      items: PagesStoreBase.pages.map(
        (option) {
          switch (option) {
            case Pages.Home:
              return BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: t.label_search,
              );
            case Pages.Favorite:
              return BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: t.label_favorite,
              );
            case Pages.History:
              return BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: t.label_history,
              );
            default:
              return const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              );
          }
        },
      ).toList(),
      onTap: (index) => store.selectPage(index),
    );
  }
}

class PageContainer extends StatelessWidget {
  const PageContainer(this.destination, {Key? key}) : super(key: key);

  final Pages destination;

  @override
  Widget build(BuildContext context) {
    switch (destination) {
      case Pages.Home:
        return Consumer6<SearchStore, ConnectivityStore, FavoritesStore,
                HistoryStore, LanguageStore, PagesStore>(
            builder: (_, searchStore, connectivityStore, favoriteStore,
                    historyStore, languageStore, pagesStore, __) =>
                SearchPage(searchStore, connectivityStore, favoriteStore,
                    historyStore, languageStore, pagesStore));
      case Pages.Favorite:
        return Consumer2<FavoritesStore, PagesStore>(
            builder: (_, favoriteStore, pagesStore, __) =>
                FavoritePage(favoriteStore, pagesStore));
      case Pages.History:
        return Consumer<HistoryStore>(
            builder: (_, historyStore, __) => HistoryPage(historyStore));
      case Pages.Result:
        return Consumer2<SearchStore, PagesStore>(
            builder: (_, searchStore, pagesStore, __) =>
                ResultPage(store: searchStore, pages: pagesStore));
      default:
        return Consumer6<SearchStore, ConnectivityStore, FavoritesStore,
                HistoryStore, LanguageStore, PagesStore>(
            builder: (_, searchStore, connectivityStore, favoriteStore,
                    historyStore, languageStore, pagesStore, __) =>
                SearchPage(searchStore, connectivityStore, favoriteStore,
                    historyStore, languageStore, pagesStore));
    }
  }
}
