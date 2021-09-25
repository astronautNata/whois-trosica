import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';

class PreferencesService {
  const PreferencesService(this._prefs);
  final SharedPreferences _prefs;
  final whoissHistory = 'history';
  final whoissFavorites = 'favorites';

  set saveListOfFavoritedWhoiss(List<WhoisResponse> list) {
    _prefs.setStringList(
        whoissFavorites, list.map((e) => jsonEncode(e.toJson())).toList());
  }

  List<WhoisResponse> get readListOfFavoritedWhoiss {
    return _prefs
            .getStringList(whoissFavorites)
            ?.map((e) => WhoisResponse.fromSharedJson(jsonDecode(e)))
            .toList() ??
        [];
  }

  set saveListOfHistoryWhoiss(List<WhoisResponse> list) {
    _prefs.setStringList(
        whoissHistory, list.map((e) => jsonEncode(e.toJson())).toList());
  }

  List<WhoisResponse> get readListOfHistorydWhoiss {
    return _prefs
            .getStringList(whoissHistory)
            ?.map((e) => WhoisResponse.fromSharedJson(jsonDecode(e)))
            .toList() ??
        [];
  }
}
