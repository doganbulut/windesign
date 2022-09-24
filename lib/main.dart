import 'package:flutter/material.dart';
import 'ui/localization/languagehelper.dart';
import 'ui/screens/mainlayout.dart';
import 'ui/screens/manufacturer/manufacturerlist.dart';
import 'windrawer/windraw.dart';

/// main is entry point of Flutter application
void main() {
  LngHelper().initLanguage('tr');
  WinDraw().testwindata();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(accentColor: Colors.red),
      debugShowCheckedModeBanner: false,
      home: ManufacturerListScreen(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
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
