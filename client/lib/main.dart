import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_trosica/constants/enums.dart';
import 'package:whois_trosica/i18n/strings.g.dart';
import 'package:whois_trosica/screens/alerts_page.dart';
import 'package:whois_trosica/screens/favorite_page.dart';
import 'package:whois_trosica/screens/history_page.dart';
import 'package:whois_trosica/screens/result_page.dart';
import 'package:whois_trosica/screens/search_page.dart';
import 'package:whois_trosica/services/localization.dart';
import 'package:whois_trosica/services/sharedpreferences.dart';
import 'package:whois_trosica/stores/alerts_store.dart';
import 'package:whois_trosica/stores/connectivity_store.dart';
import 'package:whois_trosica/stores/favorites_store.dart';
import 'package:whois_trosica/stores/history_store.dart';
import 'package:whois_trosica/stores/language_store.dart';
import 'package:whois_trosica/stores/pages_store.dart';
import 'package:whois_trosica/stores/search_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPreferedOrientation();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.grey[50]),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  final prefsService = PreferencesService(sharedPreferences);
  await Firebase.initializeApp();
  final messaging = FirebaseMessaging.instance;
  prefsService.fbToken = await messaging.getToken();
  LocaleSettings.setLocale(LocalizationPicker.returnAppLocale(
      prefsService.readPreferredLocalization));

  runApp(TranslationProvider(child: MyApp(sharedPreferences, prefsService)));
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
  final _preferencesService;

  MyApp(this.sharedPreferences, this._preferencesService, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferencesService>(
          create: (_) => _preferencesService,
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
        ProxyProvider<PreferencesService, AlertsStore>(
            update: (_, preferencesService, __) =>
                AlertsStore(preferencesService)),
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
              theme: ThemeData(primaryColor: Colors.white),
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
                  resizeToAvoidBottomInset: true,
                ),
              ),
            );
          },
        );
      }),
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
      case Pages.Alerts:
        return Consumer2<AlertsStore, PagesStore>(
            builder: (_, alertsStore, pagesStore, __) =>
                AlertsPage(alertsStore, pagesStore));
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
