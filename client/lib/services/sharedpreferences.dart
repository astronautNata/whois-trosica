import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_trosica/constants/enums.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';
import 'package:whois_trosica/services/localization.dart';

class PreferencesService {
  const PreferencesService(this._prefs);
  static const String LOCALIZATION_KEY = 'LOCALIZATION_KEY';
  final SharedPreferences _prefs;
  final whoissHistory = 'history';
  final whoissFavorites = 'favorites';

  set saveListOfFavoritedWhoiss(List<WhoisResponse> list) {
    _prefs.setStringList(whoissFavorites, list.map((e) => jsonEncode(e.toJson())).toList());
  }

  List<WhoisResponse> get readListOfFavoritedWhoiss {
    return _prefs.getStringList(whoissFavorites)?.map((e) => WhoisResponse.fromSharedJson(jsonDecode(e))).toList() ??
        [];
  }

  set saveListOfHistoryWhoiss(List<WhoisResponse> list) {
    _prefs.setStringList(whoissHistory, list.map((e) => jsonEncode(e.toJson())).toList());
  }

  List<WhoisResponse> get readListOfHistorydWhoiss {
    return _prefs.getStringList(whoissHistory)?.map((e) => WhoisResponse.fromSharedJson(jsonDecode(e))).toList() ?? [];
  }

  Locales? get readPreferredLocalization {
    if (_prefs.getString(LOCALIZATION_KEY) == null) {
      setPreferredLocalization = Locales.Latinic;
    }
    return LocalizationPicker.fromString(_prefs.getString(LOCALIZATION_KEY)!);
  }

  set setPreferredLocalization(Locales localization) {
    _prefs.setString(LOCALIZATION_KEY, LocalizationPicker.stringValue(localization));
  }
}
