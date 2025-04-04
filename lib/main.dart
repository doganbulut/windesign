import 'package:flutter/material.dart';
import 'package:windesign/winentity/windows_test.dart';
import 'ui/localization/languagehelper.dart';
import 'ui/screens/mainlayout.dart';
import 'windrawer/windraw.dart';

/// main is entry point of Flutter application
void main() {
  LngHelper().initLanguage('tr');
  WindowsTest().testMakeWin();
  //WindowsTest().testMakeWin2();
  //WindowsTest().testMakeWin3();
  //WinDraw().testwindata();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.red)),
      debugShowCheckedModeBanner: false,
      home: HomePage(key: UniqueKey()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutMain();
  }

  void _goToScreen(BuildContext context, Widget child) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => child),
      );
}
