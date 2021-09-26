import 'package:mobx/mobx.dart';
import 'package:whois_trosica/models/Failure.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';
import 'package:whois_trosica/services/network.dart';
import 'package:whois_trosica/services/sharedpreferences.dart';
import 'package:whois_trosica/stores/error_store.dart';

part 'alerts_store.g.dart';

class AlertsStore = AlertsStoreBase with _$AlertsStore;

abstract class AlertsStoreBase with Store {
  final ErrorStore errorStore = ErrorStore();
  final PreferencesService _preferencesService;

  AlertsStoreBase(this._preferencesService) {
    alertsWhoiss =
        ObservableList.of(_preferencesService.readListOfAlertsWhoiss);

    init();
  }

  @observable
  ObservableFuture subscribeFuture = ObservableFuture.value([]);

  @computed
  bool get isSubscribing => subscribeFuture.status == FutureStatus.pending;

  @observable
  ObservableList<WhoisResponse> alertsWhoiss = ObservableList.of([]);

  @observable
  bool emailEnabled = false;

  @observable
  bool fbEnabled = false;

  @observable
  String email = '';

  @action
  Future<void> toggleAlerts(WhoisResponse whois) async {
    if (containsAlerts(whois)) {
      await _removeFromAlerts(whois);
    } else {
      await _addToAlerts(whois);
    }
  }

  @action
  void toggleEmail() {
    if (!emailEnabled) {
      enableEmail();
    } else {
      enableFB();
    }
  }

  @action
  void toggleFB() {
    if (!fbEnabled) {
      enableFB();
    } else {
      enableEmail();
    }
  }

  @action
  void enableEmail() {
    _preferencesService.emailEnabled = true;
    _preferencesService.fbEnabled = false;
    emailEnabled = true;
    fbEnabled = false;
  }

  @action
  void enableFB() {
    _preferencesService.fbEnabled = true;
    _preferencesService.emailEnabled = false;
    fbEnabled = true;
    emailEnabled = false;
  }

  @action
  void setEmail(String email) {
    _preferencesService.email = email;
    this.email = email;
  }

  Future<void> _addToAlerts(WhoisResponse? whois) async {
    if (whois == null) return;

    errorStore.reset();

    final token = _preferencesService.fbToken;
    final future = Network.instance.subscribe(
      domen: whois.domen!,
      token: fbEnabled ? token : null,
      email: emailEnabled ? email : null,
    );

    try {
      subscribeFuture = ObservableFuture(future);
      await future;

      alertsWhoiss.add(whois);
      _preferencesService.saveListOfAlertsWhoiss = alertsWhoiss;
    } on Failure catch (e) {
      errorStore.errorMessage = e.message;
    }
  }

  Future<void> _removeFromAlerts(WhoisResponse? whois) async {
    if (whois == null) return;

    errorStore.reset();

    final token = _preferencesService.fbToken;
    final future = Network.instance
        .cencelSubscription(domen: whois.domen!, token: token, email: email);

    try {
      subscribeFuture = ObservableFuture(future);
      await future;

      alertsWhoiss.remove(whois);
      _preferencesService.saveListOfAlertsWhoiss = alertsWhoiss;
    } on Failure catch (e) {
      errorStore.errorMessage = e.message;
    }
  }

  bool containsAlerts(WhoisResponse whois) {
    return alertsWhoiss.contains(whois);
  }

  void init() {
    fbEnabled = _preferencesService.fbEnabled;
    emailEnabled = _preferencesService.emailEnabled;
    email = _preferencesService.email;
  }
}
