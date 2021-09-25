import 'package:mobx/mobx.dart';
import 'package:whois_trosica/models/Failure.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';
import 'package:whois_trosica/services/network.dart';
import 'package:whois_trosica/stores/error_store.dart';
import 'package:whois_trosica/stores/history_store.dart';

part 'search_store.g.dart';

class SearchStore = SearchStoreBase with _$SearchStore;

abstract class SearchStoreBase with Store {
  final ErrorStore errorStore = ErrorStore();
  final HistoryStore _historyStore;

  SearchStoreBase(this._historyStore);

  @observable
  bool whoisFetched = false;

  @observable
  ObservableFuture searchFuture = ObservableFuture.value([]);

  @computed
  bool get isWhoisLoading => searchFuture.status == FutureStatus.pending;

  @observable
  String? domen;

  @observable
  WhoisResponse? whois;

  @action
  void setDomen(String text) {
    if (text == domen) return;
    domen = text;
    search();
  }

  @action
  Future<void> search() async {
    if (domen == null) return;

    final future = Network.instance.getWhois(domen: domen!);

    try {
      searchFuture = ObservableFuture(future);
      whois = await future;
      _historyStore.addToHistory(whois!);
    } on Failure catch (e) {
      errorStore.errorMessage = e.message;
    }
  }
}
