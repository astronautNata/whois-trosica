// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlertsStore on AlertsStoreBase, Store {
  Computed<bool>? _$isSubscribingComputed;

  @override
  bool get isSubscribing =>
      (_$isSubscribingComputed ??= Computed<bool>(() => super.isSubscribing,
              name: 'AlertsStoreBase.isSubscribing'))
          .value;

  final _$subscribeFutureAtom = Atom(name: 'AlertsStoreBase.subscribeFuture');

  @override
  ObservableFuture<dynamic> get subscribeFuture {
    _$subscribeFutureAtom.reportRead();
    return super.subscribeFuture;
  }

  @override
  set subscribeFuture(ObservableFuture<dynamic> value) {
    _$subscribeFutureAtom.reportWrite(value, super.subscribeFuture, () {
      super.subscribeFuture = value;
    });
  }

  final _$alertsWhoissAtom = Atom(name: 'AlertsStoreBase.alertsWhoiss');

  @override
  ObservableList<WhoisResponse> get alertsWhoiss {
    _$alertsWhoissAtom.reportRead();
    return super.alertsWhoiss;
  }

  @override
  set alertsWhoiss(ObservableList<WhoisResponse> value) {
    _$alertsWhoissAtom.reportWrite(value, super.alertsWhoiss, () {
      super.alertsWhoiss = value;
    });
  }

  final _$emailEnabledAtom = Atom(name: 'AlertsStoreBase.emailEnabled');

  @override
  bool get emailEnabled {
    _$emailEnabledAtom.reportRead();
    return super.emailEnabled;
  }

  @override
  set emailEnabled(bool value) {
    _$emailEnabledAtom.reportWrite(value, super.emailEnabled, () {
      super.emailEnabled = value;
    });
  }

  final _$fbEnabledAtom = Atom(name: 'AlertsStoreBase.fbEnabled');

  @override
  bool get fbEnabled {
    _$fbEnabledAtom.reportRead();
    return super.fbEnabled;
  }

  @override
  set fbEnabled(bool value) {
    _$fbEnabledAtom.reportWrite(value, super.fbEnabled, () {
      super.fbEnabled = value;
    });
  }

  final _$emailAtom = Atom(name: 'AlertsStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$toggleAlertsAsyncAction = AsyncAction('AlertsStoreBase.toggleAlerts');

  @override
  Future<void> toggleAlerts(WhoisResponse whois) {
    return _$toggleAlertsAsyncAction.run(() => super.toggleAlerts(whois));
  }

  final _$AlertsStoreBaseActionController =
      ActionController(name: 'AlertsStoreBase');

  @override
  void toggleEmail() {
    final _$actionInfo = _$AlertsStoreBaseActionController.startAction(
        name: 'AlertsStoreBase.toggleEmail');
    try {
      return super.toggleEmail();
    } finally {
      _$AlertsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFB() {
    final _$actionInfo = _$AlertsStoreBaseActionController.startAction(
        name: 'AlertsStoreBase.toggleFB');
    try {
      return super.toggleFB();
    } finally {
      _$AlertsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void enableEmail() {
    final _$actionInfo = _$AlertsStoreBaseActionController.startAction(
        name: 'AlertsStoreBase.enableEmail');
    try {
      return super.enableEmail();
    } finally {
      _$AlertsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void enableFB() {
    final _$actionInfo = _$AlertsStoreBaseActionController.startAction(
        name: 'AlertsStoreBase.enableFB');
    try {
      return super.enableFB();
    } finally {
      _$AlertsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String email) {
    final _$actionInfo = _$AlertsStoreBaseActionController.startAction(
        name: 'AlertsStoreBase.setEmail');
    try {
      return super.setEmail(email);
    } finally {
      _$AlertsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
subscribeFuture: ${subscribeFuture},
alertsWhoiss: ${alertsWhoiss},
emailEnabled: ${emailEnabled},
fbEnabled: ${fbEnabled},
email: ${email},
isSubscribing: ${isSubscribing}
    ''';
  }
}
