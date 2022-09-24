import 'package:windesign/ui/localization/language/language_tr.dart';

import 'language/language_en.dart';
import 'language/languages.dart';

class LngHelper {
  static final LngHelper _singleton = LngHelper._internal();
  Languages words;

  factory LngHelper() {
    return _singleton;
  }
  LngHelper._internal();

  void initLanguage(String lang) {
    if (lang == 'tr') this.words = new LanguageTr();
    if (lang == 'en') this.words = new LanguageEn();
  }
}
