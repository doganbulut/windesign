import 'dart:ui';
import 'package:windesign/ui/localization/languagehelper.dart';

class LocaleConstant {
  static Language _language = Language.en;

  static Future<Locale> getLocale() async {
    return _locale(_language);
  }

  static Future<void> setLocale(Language language) async {
    _language = language;
  }

  static Locale _locale(Language language) {
    switch (language) {
      case Language.tr:
        return const Locale('tr', 'TR');
      case Language.en:
        return const Locale('en', 'US');
      default:
        return const Locale('en', 'US');
    }
  }

  static void changeLanguage(Language selectedLanguage) async {
    await setLocale(selectedLanguage);
    LngHelper(language: selectedLanguage);
  }

  static Language get language => _language;
}
