
/*
 * Generated file. Do not edit.
 * 
 * Locales: 3
<<<<<<< HEAD
 * Strings: 57 (19.0 per locale)
 * 
 * Built on 2021-09-26 at 16:36 UTC
=======
 * Strings: 60 (20.0 per locale)
 * 
 * Built on 2021-09-26 at 15:40 UTC
>>>>>>> 4c1917122dc45bb8213a54268e6841dee416a1d6
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
	en, // 'en' (base locale, fallback)
	srCyrl, // 'sr-Cyrl'
	srLatn, // 'sr-Latn'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn _t = _currLocale.translations;
_StringsEn get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	/// Hint for pre 4.x.x developers: You can access the raw string via LocaleSettings.useDeviceLocale().languageTag
	static AppLocale useDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance?.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			return setLocaleRaw(deviceLocale);
		} else {
			return setLocale(_baseLocale);
		}
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static AppLocale setLocale(AppLocale locale) {
		_currLocale = locale;
		_t = _currLocale.translations;

		if (WidgetsBinding.instance != null) {
			// force rebuild if TranslationProvider is used
			_translationProviderKey.currentState?.setLocale(_currLocale);
		}

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale setLocaleRaw(String localeRaw) {
		final selected = _selectLocale(localeRaw);
		return setLocale(selected ?? _baseLocale);
	}

	/// Gets current locale.
	/// Hint for pre 4.x.x developers: You can access the raw string via LocaleSettings.currentLocale.languageTag
	static AppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	/// Hint for pre 4.x.x developers: You can access the raw string via LocaleSettings.baseLocale.languageTag
	static AppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return AppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return AppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}

}

// context enums

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {
	_StringsEn get translations {
		switch (this) {
			case AppLocale.en: return _StringsEn._instance;
			case AppLocale.srCyrl: return _StringsSrCyrl._instance;
			case AppLocale.srLatn: return _StringsSrLatn._instance;
		}
	}

	String get languageTag {
		switch (this) {
			case AppLocale.en: return 'en';
			case AppLocale.srCyrl: return 'sr-Cyrl';
			case AppLocale.srLatn: return 'sr-Latn';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case AppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
			case AppLocale.srCyrl: return const Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Cyrl', );
			case AppLocale.srLatn: return const Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn', );
		}
	}
}

extension StringAppLocaleExtensions on String {
	AppLocale? toAppLocale() {
		switch (this) {
			case 'en': return AppLocale.en;
			case 'sr-Cyrl': return AppLocale.srCyrl;
			case 'sr-Latn': return AppLocale.srLatn;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();
}

class _TranslationProviderState extends State<TranslationProvider> {
	AppLocale locale = _currLocale;

	void setLocale(AppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final AppLocale locale;
	final _StringsEn translations; // store translations to avoid switch call
	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	AppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = AppLocale.values
			.cast<AppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

class _StringsEn {
	_StringsEn._(); // no constructor

	static final _StringsEn _instance = _StringsEn._();

	String get label_search => 'Pretraga';
	String get label_history => 'Istorija';
	String get label_favorite => 'Omiljeno';
	String get label_insert_domen => 'Unesite domen';
	String get home_title1 => 'Pretrazi i upravljaj ';
	String get home_title2 => 'domacim domenima';
	String get home_last_search => 'POSLEDNJE PRETRAGE';
	String get enter_domain => 'Unesi domen ovde';
	String get alert_turn_on => 'Ukljuci';
	String get alert_cancel => 'Otkazi';
	String get turn_remainder => 'Ukljuci podsetnik?';
	String get domain_found => 'je pronadjen!';
	String get domain_not_found => 'nije pronadjen!';
	String get favorite_domains => 'Omiljeni domeni';
	String get domain_owner => 'Vlasnik';
	String get registration_date => 'Datum registrovanja';
	String get expiration_date => 'Datum isteka';
<<<<<<< HEAD
	String get copied => 'Kopirano!';
	String get raw_result => 'Prikaži kompletan rezultat';
=======
	String get no_internet_connection => 'Nema internet konekcije';
	String get cannot_find_domain => 'Ne mozemo da pronadjemo domen';
	String get bad_response => 'Unesite validan domen';
>>>>>>> 4c1917122dc45bb8213a54268e6841dee416a1d6

	/// A flat map containing all translations.
	dynamic operator[](String key) {
		return _translationMap[AppLocale.en]![key];
	}
}

class _StringsSrCyrl implements _StringsEn {
	_StringsSrCyrl._(); // no constructor

	static final _StringsSrCyrl _instance = _StringsSrCyrl._();

	@override String get label_search => 'Претрага';
	@override String get label_history => 'Историја';
	@override String get label_favorite => 'Омиљено';
	@override String get label_insert_domen => 'Унесите домен';
	@override String get home_title1 => 'Претражи и управљај ';
	@override String get home_title2 => 'домаћим доменима';
	@override String get home_last_search => 'ПОСЛЕДЊЕ ПРЕТРАГЕ';
	@override String get enter_domain => 'Унеси домен овде';
	@override String get alert_turn_on => 'Укључи';
	@override String get alert_cancel => 'Откажи';
	@override String get turn_remainder => 'Укључи подсетник?';
	@override String get domain_found => 'је пронађен!';
	@override String get domain_not_found => 'није пронађен!';
	@override String get favorite_domains => 'Омиљени домени';
	@override String get domain_owner => 'Власник';
	@override String get registration_date => 'Датум регистровања';
	@override String get expiration_date => 'Датум истека';
<<<<<<< HEAD
	@override String get copied => 'Копирано!';
	@override String get raw_result => 'Прикажи комплетан резултат';
=======
	@override String get no_internet_connection => 'Нема интернет конекције';
	@override String get cannot_find_domain => 'Не можемо да пронађемо домен';
	@override String get bad_response => 'Унесите валидан домен';
>>>>>>> 4c1917122dc45bb8213a54268e6841dee416a1d6

	/// A flat map containing all translations.
	@override
	dynamic operator[](String key) {
		return _translationMap[AppLocale.srCyrl]![key];
	}
}

class _StringsSrLatn implements _StringsEn {
	_StringsSrLatn._(); // no constructor

	static final _StringsSrLatn _instance = _StringsSrLatn._();

	@override String get label_search => 'Pretraga';
	@override String get label_history => 'Istorija';
	@override String get label_favorite => 'Omiljeno';
	@override String get label_insert_domen => 'Unesite domen';
	@override String get home_title1 => 'Pretrazi i upravljaj ';
	@override String get home_title2 => 'domacim domenima';
	@override String get home_last_search => 'POSLEDNJE PRETRAGE';
	@override String get enter_domain => 'Unesi domen ovde';
	@override String get alert_turn_on => 'Ukljuci';
	@override String get alert_cancel => 'Otkazi';
	@override String get turn_remainder => 'Ukljuci podsetnik?';
	@override String get domain_found => 'je pronadjen!';
	@override String get domain_not_found => 'nije pronadjen!';
	@override String get favorite_domains => 'Omiljeni domeni';
	@override String get domain_owner => 'Vlasnik';
	@override String get registration_date => 'Datum registrovanja';
	@override String get expiration_date => 'Datum isteka';
<<<<<<< HEAD
	@override String get copied => 'Kopirano!';
	@override String get raw_result => 'Prikaži kompletan rezultat';
=======
	@override String get no_internet_connection => 'Nema internet konekcije';
	@override String get cannot_find_domain => 'Ne mozemo da pronadjemo domen';
	@override String get bad_response => 'Unesite validan domen';
>>>>>>> 4c1917122dc45bb8213a54268e6841dee416a1d6

	/// A flat map containing all translations.
	@override
	dynamic operator[](String key) {
		return _translationMap[AppLocale.srLatn]![key];
	}
}

/// A flat map containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
late Map<AppLocale, Map<String, dynamic>> _translationMap = {
	AppLocale.en: {
		'label_search': 'Pretraga',
		'label_history': 'Istorija',
		'label_favorite': 'Omiljeno',
		'label_insert_domen': 'Unesite domen',
		'home_title1': 'Pretrazi i upravljaj ',
		'home_title2': 'domacim domenima',
		'home_last_search': 'POSLEDNJE PRETRAGE',
		'enter_domain': 'Unesi domen ovde',
		'alert_turn_on': 'Ukljuci',
		'alert_cancel': 'Otkazi',
		'turn_remainder': 'Ukljuci podsetnik?',
		'domain_found': 'je pronadjen!',
		'domain_not_found': 'nije pronadjen!',
		'favorite_domains': 'Omiljeni domeni',
		'domain_owner': 'Vlasnik',
		'registration_date': 'Datum registrovanja',
		'expiration_date': 'Datum isteka',
<<<<<<< HEAD
		'copied': 'Kopirano!',
		'raw_result': 'Prikaži kompletan rezultat',
=======
		'no_internet_connection': 'Nema internet konekcije',
		'cannot_find_domain': 'Ne mozemo da pronadjemo domen',
		'bad_response': 'Unesite validan domen',
>>>>>>> 4c1917122dc45bb8213a54268e6841dee416a1d6
	},
	AppLocale.srCyrl: {
		'label_search': 'Претрага',
		'label_history': 'Историја',
		'label_favorite': 'Омиљено',
		'label_insert_domen': 'Унесите домен',
		'home_title1': 'Претражи и управљај ',
		'home_title2': 'домаћим доменима',
		'home_last_search': 'ПОСЛЕДЊЕ ПРЕТРАГЕ',
		'enter_domain': 'Унеси домен овде',
		'alert_turn_on': 'Укључи',
		'alert_cancel': 'Откажи',
		'turn_remainder': 'Укључи подсетник?',
		'domain_found': 'је пронађен!',
		'domain_not_found': 'није пронађен!',
		'favorite_domains': 'Омиљени домени',
		'domain_owner': 'Власник',
		'registration_date': 'Датум регистровања',
		'expiration_date': 'Датум истека',
<<<<<<< HEAD
		'copied': 'Копирано!',
		'raw_result': 'Прикажи комплетан резултат',
=======
		'no_internet_connection': 'Нема интернет конекције',
		'cannot_find_domain': 'Не можемо да пронађемо домен',
		'bad_response': 'Унесите валидан домен',
>>>>>>> 4c1917122dc45bb8213a54268e6841dee416a1d6
	},
	AppLocale.srLatn: {
		'label_search': 'Pretraga',
		'label_history': 'Istorija',
		'label_favorite': 'Omiljeno',
		'label_insert_domen': 'Unesite domen',
		'home_title1': 'Pretrazi i upravljaj ',
		'home_title2': 'domacim domenima',
		'home_last_search': 'POSLEDNJE PRETRAGE',
		'enter_domain': 'Unesi domen ovde',
		'alert_turn_on': 'Ukljuci',
		'alert_cancel': 'Otkazi',
		'turn_remainder': 'Ukljuci podsetnik?',
		'domain_found': 'je pronadjen!',
		'domain_not_found': 'nije pronadjen!',
		'favorite_domains': 'Omiljeni domeni',
		'domain_owner': 'Vlasnik',
		'registration_date': 'Datum registrovanja',
		'expiration_date': 'Datum isteka',
<<<<<<< HEAD
		'copied': 'Kopirano!',
		'raw_result': 'Prikaži kompletan rezultat',
=======
		'no_internet_connection': 'Nema internet konekcije',
		'cannot_find_domain': 'Ne mozemo da pronadjemo domen',
		'bad_response': 'Unesite validan domen',
>>>>>>> 4c1917122dc45bb8213a54268e6841dee416a1d6
	},
};
