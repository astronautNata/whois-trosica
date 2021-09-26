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
  bool? isErrorVisible = false;

  @observable
  WhoisResponse? whois;

  @action
  Future<void> setDomen(String text) async {
    if (text == domen) return;
    domen = text;
    await search();
  }

  @action
  void setErrorVisibillity(bool value) {
    isErrorVisible = value;
  }

  @action
  Future<void> search() async {
    if (domen == null) return;

    errorStore.reset();
    final future = Network.instance.getWhois(domen: domen!);

    try {
      searchFuture = ObservableFuture(future);
      whois = await future;
      _historyStore.toggleHistory(whois!);
    } on Failure catch (e) {
      errorStore.errorMessage = e.message;
    }
  }
}
