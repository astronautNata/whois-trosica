import 'package:mobx/mobx.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';
import 'package:whois_trosica/services/sharedpreferences.dart';

part 'history_store.g.dart';

class HistoryStore = HistoryStoreBase with _$HistoryStore;

abstract class HistoryStoreBase with Store {
  final PreferencesService _preferencesService;

  HistoryStoreBase(this._preferencesService) {
    historyWhoiss =
        ObservableList.of(_preferencesService.readListOfHistorydWhoiss);
  }

  @observable
  ObservableList<WhoisResponse> historyWhoiss = ObservableList.of([]);

  @action
  void addToHistory(WhoisResponse whois) {
    historyWhoiss.add(whois);
    _preferencesService.saveListOfHistoryWhoiss = historyWhoiss;
  }

  @action
  void removeFromHistory(WhoisResponse whois) {
    historyWhoiss.remove(whois);
    _preferencesService.saveListOfHistoryWhoiss = historyWhoiss;
  }

  bool containsHistory(WhoisResponse whois) {
    return historyWhoiss.contains(whois);
  }
}
