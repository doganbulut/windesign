import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:json_form_generator/json_form_generator.dart';
import 'package:windesign/helpers/apihelper.dart';
import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/serie.dart';
import 'package:windesign/ui/localization/languagehelper.dart';
import 'package:windesign/ui/screens/profileforms/listmanufacturerpage.dart';

class AddManufacturerPage extends StatefulWidget {
  @override
  _AddManufacturerPage createState() => _AddManufacturerPage();
}

class _AddManufacturerPage extends State<AddManufacturerPage> {
  dynamic response;
  var _formkey = GlobalKey<FormState>();

  String form = json.encode([
    {
      "title": "name",
      "label": LngHelper().words.lblManufacturerInfo,
      "type": "text",
      "required": "yes"
    }
  ]);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LngHelper().words.lblManufacturer),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(children: <Widget>[
                JsonFormGenerator(
                  form: form,
                  onChanged: (dynamic value) {
                    //print(value);
                    setState(() {
                      this.response = value;
                    });
                  },
                ),
                new ElevatedButton(
                    child: new Text(LngHelper().words.lblSave),
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        //print(this.response.toString());
                        createData(this.response);
                      }
                    })
              ]),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: new ElevatedButton(
                child: new Text(LngHelper().words.lblManufacturerList),
                onPressed: () async {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => ListManufacturerPage()));
                }),
          ),
        ],
      ),
    );
  }

  createData(Map response) async {
    try {
      MapEntry mp = response.entries
          .firstWhere((element) => element.key == 'name', orElse: () => null);

      if (mp != null) {
        Manufacturer manufacturer =
            // ignore: deprecated_member_use
            new Manufacturer(name: mp.value, series: new List<Serie>());
        ApiHelper api = new ApiHelper();
        if (await api.postTable('manufacturer', manufacturer.toJson())) {}
      }
    } catch (e) {
      print(e);
    }
  }
}
