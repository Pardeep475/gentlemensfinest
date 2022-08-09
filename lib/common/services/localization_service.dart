import 'dart:ui';

import 'package:gentleman_finest/common/lang/de_de.dart';
import 'package:get/get.dart';

import '../app_strings.dart';
import '../lang/en_us.dart';

class LocalizationService extends Translations {
  // Default locale
  static const locale =  Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('so', 'SO');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [AppStrings.english, AppStrings.german];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [const Locale('en', 'US'), const Locale('de', 'DE')];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS, // lang/en_us.dart
        'so_SO': deDE, // lang/de_de.dart
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return locales[0];
    // return Get.locale;
  }
}
