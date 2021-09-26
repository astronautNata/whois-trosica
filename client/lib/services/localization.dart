import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:whois_trosica/constants/enums.dart';
import 'package:whois_trosica/i18n/strings.g.dart';

class LocalizationPicker {
  static const Locales DEFAULT_LOCALE = Locales.Latinic;
  static String stringValue(Locales type) {
    return EnumToString.convertToString(type);
  }

  static Locales fromString(String value) {
    return EnumToString.fromString(Locales.values, value) ?? DEFAULT_LOCALE;
  }

  static String displayValue(Locales locale) {
    switch (locale) {
      case Locales.Cyrilic:
        return 'Ћирилица';
      case Locales.Latinic:
        return 'Latinica';
      default:
        return 'Ћирилица';
    }
  }

  static Locale returnLocale(Locales? localization) {
    switch (localization) {
      case Locales.Latinic:
        return Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn');
      case Locales.Cyrilic:
        return Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Cyrl');
      default:
        return Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Cyrl');
    }
  }

  static AppLocale returnAppLocale(Locales? localization) {
    switch (localization) {
      case Locales.Latinic:
        return AppLocale.srLatn;
      case Locales.Cyrilic:
        return AppLocale.srCyrl;
      default:
        return AppLocale.srLatn;
    }
  }
}
