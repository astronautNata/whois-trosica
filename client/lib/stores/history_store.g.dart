// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoryStore on HistoryStoreBase, Store {
  final _$historyWhoissAtom = Atom(name: 'HistoryStoreBase.historyWhoiss');

  @override
  ObservableList<WhoisResponse> get historyWhoiss {
    _$historyWhoissAtom.reportRead();
    return super.historyWhoiss;
  }

  @override
  set historyWhoiss(ObservableList<WhoisResponse> value) {
    _$historyWhoissAtom.reportWrite(value, super.historyWhoiss, () {
      super.historyWhoiss = value;
    });
  }

  final _$HistoryStoreBaseActionController =
      ActionController(name: 'HistoryStoreBase');

  @override
  void toggleHistory(WhoisResponse whois) {
    final _$actionInfo = _$HistoryStoreBaseActionController.startAction(
        name: 'HistoryStoreBase.toggleHistory');
    try {
      return super.toggleHistory(whois);
    } finally {
      _$HistoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
historyWhoiss: ${historyWhoiss}
    ''';
  }
}
