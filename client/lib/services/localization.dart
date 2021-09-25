import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:whois_trosica/constants/enums.dart';

class LocalizationPicker {
  static const Locales DEFAULT_LOCALE = Locales.Latinic;
  static String stringValue(Locales type) {
    return EnumToString.convertToString(type);
  }

  static Locales fromString(String value) {
    return EnumToString.fromString(Locales.values, value) ?? DEFAULT_LOCALE;
  }

  static Locale returnLocale(Locales? localization) {
    switch (localization) {
      case Locales.Latinic:
        return Locale('en');
      case Locales.Cyrilic:
        return Locale('sr');
      default:
        return Locale('en');
    }
  }
}
