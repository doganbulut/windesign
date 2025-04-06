import 'package:windesign/ui/localization/language/language_tr.dart';
import 'language/language_en.dart';
import 'language/languages.dart';

enum Language { en, tr, unknown }

class LngHelper {
  static final LngHelper _singleton = LngHelper._internal();
  Languages _words;
  final Language _language;

  factory LngHelper({Language language = Language.en}) {
    _singleton._initLanguage(language);
    return _singleton;
  }

  LngHelper._internal()
      : _language = Language.en,
        _words = LanguageEn();

  void _initLanguage(Language language) {
    switch (language) {
      case Language.tr:
        _singleton._words = LanguageTr();
        break;
      case Language.en:
        _singleton._words = LanguageEn();
        break;
      default:
        _singleton._words = LanguageEn();
        break;
    }
  }

  Languages get words => _words;
  Language get language => _language;
}
