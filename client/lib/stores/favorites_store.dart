import 'package:mobx/mobx.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';
import 'package:whois_trosica/services/sharedpreferences.dart';

part 'favorites_store.g.dart';

class FavoritesStore = FavoritesStoreBase with _$FavoritesStore;

abstract class FavoritesStoreBase with Store {
  final PreferencesService _preferencesService;

  FavoritesStoreBase(this._preferencesService) {
    favoriteWhoiss =
        ObservableList.of(_preferencesService.readListOfFavoritedWhoiss);
  }

  @observable
  ObservableList<WhoisResponse> favoriteWhoiss = ObservableList.of([]);

  @action
  void toggleFavorite(WhoisResponse whois) {
    if (containsFavorite(whois)) {
      removeFromFavorite(whois);
    } else {
      addToFavorite(whois);
    }
  }

  @action
  void addToFavorite(WhoisResponse whois) {
    if (!containsFavorite(whois)) {
      favoriteWhoiss.add(whois);
      _preferencesService.saveListOfFavoritedWhoiss = favoriteWhoiss;
    }
  }

  @action
  void removeFromFavorite(WhoisResponse whois) {
    if (containsFavorite(whois)) {
      favoriteWhoiss.remove(whois);
      _preferencesService.saveListOfFavoritedWhoiss = favoriteWhoiss;
    }
  }

  bool containsFavorite(WhoisResponse whois) {
    return favoriteWhoiss.contains(whois);
  }
}
