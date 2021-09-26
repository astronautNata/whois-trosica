// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on SearchStoreBase, Store {
  Computed<bool>? _$isWhoisLoadingComputed;

  @override
  bool get isWhoisLoading =>
      (_$isWhoisLoadingComputed ??= Computed<bool>(() => super.isWhoisLoading,
              name: 'SearchStoreBase.isWhoisLoading'))
          .value;

  final _$whoisFetchedAtom = Atom(name: 'SearchStoreBase.whoisFetched');

  @override
  bool get whoisFetched {
    _$whoisFetchedAtom.reportRead();
    return super.whoisFetched;
  }

  @override
  set whoisFetched(bool value) {
    _$whoisFetchedAtom.reportWrite(value, super.whoisFetched, () {
      super.whoisFetched = value;
    });
  }

  final _$searchFutureAtom = Atom(name: 'SearchStoreBase.searchFuture');

  @override
  ObservableFuture<dynamic> get searchFuture {
    _$searchFutureAtom.reportRead();
    return super.searchFuture;
  }

  @override
  set searchFuture(ObservableFuture<dynamic> value) {
    _$searchFutureAtom.reportWrite(value, super.searchFuture, () {
      super.searchFuture = value;
    });
  }

  final _$domenAtom = Atom(name: 'SearchStoreBase.domen');

  @override
  String? get domen {
    _$domenAtom.reportRead();
    return super.domen;
  }

  @override
  set domen(String? value) {
    _$domenAtom.reportWrite(value, super.domen, () {
      super.domen = value;
    });
  }

  final _$whoisAtom = Atom(name: 'SearchStoreBase.whois');

  @override
  WhoisResponse? get whois {
    _$whoisAtom.reportRead();
    return super.whois;
  }

  @override
  set whois(WhoisResponse? value) {
    _$whoisAtom.reportWrite(value, super.whois, () {
      super.whois = value;
    });
  }

  final _$setDomenAsyncAction = AsyncAction('SearchStoreBase.setDomen');

  @override
  Future<void> setDomen(String text) {
    return _$setDomenAsyncAction.run(() => super.setDomen(text));
  }

  final _$searchAsyncAction = AsyncAction('SearchStoreBase.search');

  @override
  Future<void> search() {
    return _$searchAsyncAction.run(() => super.search());
  }

  @override
  String toString() {
    return '''
whoisFetched: ${whoisFetched},
searchFuture: ${searchFuture},
domen: ${domen},
whois: ${whois},
isWhoisLoading: ${isWhoisLoading}
    ''';
  }
}
