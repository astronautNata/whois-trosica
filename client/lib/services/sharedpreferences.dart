import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_trosica/constants/enums.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';
import 'package:whois_trosica/services/localization.dart';

class PreferencesService {
  const PreferencesService(this._prefs);
  static const String LOCALIZATION_KEY = 'LOCALIZATION_KEY';
  static const String WHO_IS_HISTORY = 'history';
  static const String WHO_IS_FAVORITES = 'favorites';
  static const String FB_TOKEN = 'FBTOKEN';
  final SharedPreferences _prefs;

  set saveListOfFavoritedWhoiss(List<WhoisResponse> list) {
    _prefs.setStringList(
        WHO_IS_FAVORITES, list.map((e) => jsonEncode(e.toJson())).toList());
  }

  List<WhoisResponse> get readListOfFavoritedWhoiss {
    return _prefs
            .getStringList(WHO_IS_FAVORITES)
            ?.map((e) => WhoisResponse.fromSharedJson(jsonDecode(e)))
            .toList() ??
        [];
  }

  set saveListOfHistoryWhoiss(List<WhoisResponse> list) {
    _prefs.setStringList(
        WHO_IS_HISTORY, list.map((e) => jsonEncode(e.toJson())).toList());
  }

  List<WhoisResponse> get readListOfHistorydWhoiss {
    return _prefs
            .getStringList(WHO_IS_HISTORY)
            ?.map((e) => WhoisResponse.fromSharedJson(jsonDecode(e)))
            .toList() ??
        [];
  }

  Locales? get readPreferredLocalization {
    if (_prefs.getString(LOCALIZATION_KEY) == null) {
      setPreferredLocalization = Locales.Latinic;
    }
    return LocalizationPicker.fromString(_prefs.getString(LOCALIZATION_KEY)!);
  }

  set setPreferredLocalization(Locales localization) {
    _prefs.setString(
        LOCALIZATION_KEY, LocalizationPicker.stringValue(localization));
  }

  String? get fbToken {
    return _prefs.getString(FB_TOKEN);
  }

  set fbToken(String? token) {
    if (token != null) _prefs.setString(FB_TOKEN, token);
  }
}
