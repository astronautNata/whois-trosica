import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_trosica/constants/enums.dart';
import 'package:whois_trosica/screens/favorite_page.dart';
import 'package:whois_trosica/screens/history_page.dart';
import 'package:whois_trosica/screens/search_page.dart';
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

class MyApp extends StatelessWidget {
  final _pagesStore = PagesStore();
  final SharedPreferences sharedPreferences;

  MyApp(this.sharedPreferences, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferencesService>(
          create: (_) => PreferencesService(sharedPreferences),
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
      child: MaterialApp(
        title: 'whoisTrosica',
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
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
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text('whoisTrosica'));
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
              return const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              );
            case Pages.Favorite:
              return const BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              );
            case Pages.History:
              return const BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
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
