import 'package:flutter/material.dart';
import 'package:windesign/app_theme.dart';
import 'package:windesign/ui/localization/languagehelper.dart';
import 'package:windesign/ui/localization/localeconstant.dart';
import 'package:windesign/ui/screens/mainlayout.dart';

/// main is entry point of Flutter application
void main() {
  LngHelper(language: Language.tr);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: LayoutMain(),
      locale: LocaleConstant.language == Language.tr
          ? const Locale('tr', 'TR')
          : const Locale('en', 'US'),
    );
  }
}
