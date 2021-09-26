import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:whois_trosica/constants/enums.dart';
import 'package:whois_trosica/services/sharedpreferences.dart';
import 'package:whois_trosica/stores/error_store.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  final PreferencesService _prefs;
  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // supported languages
  List<Locale> supportedLanguages = [
    Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Cyrl'),
    Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn')
  ];

  _LanguageStore(PreferencesService repository) : _prefs = repository {
    init();
  }

  @observable
  Locales _locale = Locales.Latinic;

  @computed
  Locales get locale => _locale;

  @action
  void changeLanguage(Locales value) {
    _locale = value;
    _prefs.setPreferredLocalization = value;
  }

  void init() async {
    if (_prefs.readPreferredLocalization != null) {
      _locale = _prefs.readPreferredLocalization!;
    }
  }
}
