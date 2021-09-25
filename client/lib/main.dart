import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_trosica/constants/enums.dart';
import 'package:whois_trosica/i18n/strings.g.dart';
import 'package:whois_trosica/screens/favorite_page.dart';
import 'package:whois_trosica/screens/history_page.dart';
import 'package:whois_trosica/screens/search_page.dart';
import 'package:whois_trosica/services/localization.dart';
import 'package:whois_trosica/services/sharedpreferences.dart';
import 'package:whois_trosica/stores/connectivity_store.dart';
import 'package:whois_trosica/stores/favorites_store.dart';
import 'package:whois_trosica/stores/history_store.dart';
import 'package:whois_trosica/stores/pages_store.dart';
import 'package:whois_trosica/stores/search_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  MyApp(this.sharedPreferences, {Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState(sharedPreferences);
}

class _MyAppState extends State<MyApp> {
  final SharedPreferences sharedPreferences;
  final _pagesStore = PagesStore();
  late final PreferencesService _preferencesService;
  _MyAppState(this.sharedPreferences);

  @override
  void initState() {
    super.initState();
    _preferencesService = PreferencesService(widget.sharedPreferences);

    final userLocalization = _preferencesService.readPreferredLocalization;
    final returnLocale = LocalizationPicker.returnLocale(userLocalization);
    LocaleSettings.setLocaleRaw(returnLocale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferencesService>(
          create: (_) => PreferencesService(widget.sharedPreferences),
        ),
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
      child: TranslationProvider(
        child: MaterialApp(
          title: 'whoisTrosica',
          theme: ThemeData(primarySwatch: Colors.blue),
          debugShowCheckedModeBanner: false,
          supportedLocales: LocaleSettings.supportedLocales,
          locale: LocalizationPicker.returnLocale(
              _preferencesService.readPreferredLocalization),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: resolution(fallback: Locale('en', 'US')),
          home: Observer(
            builder: (_) => Scaffold(
              appBar: _buildAppBar(),
              body: SafeArea(
                child: PageContainer(_pagesStore.selectedDestination),
              ),
              bottomNavigationBar: AppBottomNavigationBar(_pagesStore),
            ),
          ),
        ),
      ),
    );
  }

  LocaleResolutionCallback resolution({Locale? fallback}) {
    return (Locale? locale, Iterable<Locale> supported) {
      if (locale != null && isSupported(locale)) {
        return locale;
      }
      final fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  bool isSupported(Locale locale) {
    for (var i = 0; i < LocaleSettings.supportedLocales.length; i++) {
      final l = LocaleSettings.supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

AppBar _buildAppBar() {
  return AppBar(title: Text('whoisTrosica'));
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
        return Consumer3<SearchStore, ConnectivityStore, FavoritesStore>(
            builder: (_, searchStore, connectivityStore, favoriteStore, __) =>
                SearchPage(searchStore, connectivityStore, favoriteStore));
      case Pages.Favorite:
        return Consumer<FavoritesStore>(
            builder: (_, favoriteStore, __) => FavoritePage(favoriteStore));
      case Pages.History:
        return Consumer<HistoryStore>(
            builder: (_, historyStore, __) => HistoryPage(historyStore));
      default:
        return Consumer3<SearchStore, ConnectivityStore, FavoritesStore>(
            builder: (_, searchStore, connectivityStore, favoriteStore, __) =>
                SearchPage(searchStore, connectivityStore, favoriteStore));
    }
  }
}
