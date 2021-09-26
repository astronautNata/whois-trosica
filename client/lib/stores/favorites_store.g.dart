// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritesStore on FavoritesStoreBase, Store {
  final _$favoriteWhoissAtom = Atom(name: 'FavoritesStoreBase.favoriteWhoiss');

  @override
  ObservableList<WhoisResponse> get favoriteWhoiss {
    _$favoriteWhoissAtom.reportRead();
    return super.favoriteWhoiss;
  }

  @override
  set favoriteWhoiss(ObservableList<WhoisResponse> value) {
    _$favoriteWhoissAtom.reportWrite(value, super.favoriteWhoiss, () {
      super.favoriteWhoiss = value;
    });
  }

  final _$FavoritesStoreBaseActionController =
      ActionController(name: 'FavoritesStoreBase');

  @override
  void toggleFavorite(WhoisResponse whois) {
    final _$actionInfo = _$FavoritesStoreBaseActionController.startAction(
        name: 'FavoritesStoreBase.toggleFavorite');
    try {
      return super.toggleFavorite(whois);
    } finally {
      _$FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToFavorite(WhoisResponse whois) {
    final _$actionInfo = _$FavoritesStoreBaseActionController.startAction(
        name: 'FavoritesStoreBase.addToFavorite');
    try {
      return super.addToFavorite(whois);
    } finally {
      _$FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromFavorite(WhoisResponse whois) {
    final _$actionInfo = _$FavoritesStoreBaseActionController.startAction(
        name: 'FavoritesStoreBase.removeFromFavorite');
    try {
      return super.removeFromFavorite(whois);
    } finally {
      _$FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoriteWhoiss: ${favoriteWhoiss}
    ''';
  }
}
