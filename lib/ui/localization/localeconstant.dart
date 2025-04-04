import 'package:flutter/material.dart';

String languageCode = "tr";

Future<Locale> setLocale(String languageCode) async {
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale('tr', 'TR');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  //MyApp.setLocale(context, _locale);
}
