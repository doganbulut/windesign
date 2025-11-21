import 'package:flutter/material.dart';
import 'package:windesign/profentity/manufacturer.dart';

class EditProfilePage extends StatefulWidget {
  Manufacturer manufacturer;
  String serie;
  EditProfilePage({Key key, this.manufacturer, this.serie}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profiles"),
      ),
      body: Center(
        child: Text("Editable grid temporarily disabled due to dependency issues."),
      ),
    );
  }
}
