import 'package:flutter/material.dart';
import 'package:windesign/ui/localization/languagehelper.dart';
import 'package:windesign/ui/screens/drawscreen.dart';

class LayoutMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //title: Text(LngHelper().words.appName),
      drawer: getLeftMenu(),
      body: DrawScreen(),
    );
  }

  Widget getLeftMenu() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: Text(LngHelper().words.lblCustomers),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text(LngHelper().words.lblOrders),
        ),
        ListTile(
          leading: Icon(Icons.library_books),
          title: Text(LngHelper().words.lblProfileDesc),
        ),
        ListTile(
          leading: Icon(Icons.help),
          title: Text(LngHelper().words.lblProgramParameters),
        ),
      ],
    );
  }
}
