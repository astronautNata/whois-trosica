// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LanguageStore on _LanguageStore, Store {
  Computed<Locales>? _$localeComputed;

  @override
  Locales get locale => (_$localeComputed ??=
          Computed<Locales>(() => super.locale, name: '_LanguageStore.locale'))
      .value;

  final _$_localeAtom = Atom(name: '_LanguageStore._locale');

  @override
  Locales get _locale {
    _$_localeAtom.reportRead();
    return super._locale;
  }

  @override
  set _locale(Locales value) {
    _$_localeAtom.reportWrite(value, super._locale, () {
      super._locale = value;
    });
  }

  final _$_LanguageStoreActionController =
      ActionController(name: '_LanguageStore');

  @override
  void changeLanguage(Locales value) {
    final _$actionInfo = _$_LanguageStoreActionController.startAction(
        name: '_LanguageStore.changeLanguage');
    try {
      return super.changeLanguage(value);
    } finally {
      _$_LanguageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale}
    ''';
  }
}
