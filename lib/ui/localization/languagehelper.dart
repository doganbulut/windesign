import 'package:windesign/ui/localization/language/language_tr.dart';
import 'language/language_en.dart';
import 'language/languages.dart';

class LngHelper {
  static final LngHelper _singleton = LngHelper._internal();
  late Languages words;

  factory LngHelper() {
    return _singleton;
  }

  LngHelper._internal() {
    // Default to English if no language is set
    initLanguage('en');
  }

  void initLanguage(String lang) {
    if (lang == 'tr') {
      words = LanguageTr();
    } else if (lang == 'en') {
      words = LanguageEn();
    } else {
      // Handle unsupported languages (e.g., default to English)
      words = LanguageEn();
    }
  }
}
