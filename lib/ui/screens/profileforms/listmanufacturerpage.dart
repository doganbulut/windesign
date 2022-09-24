import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:windesign/helpers/apihelper.dart';
import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/serie.dart';
import 'package:windesign/ui/localization/languagehelper.dart';
import 'package:windesign/ui/screens/profileforms/editprofilepage.dart';

class ListManufacturerPage extends StatefulWidget {
  ListManufacturerPage({Key key}) : super(key: key);

  @override
  _ListManufacturerPageState createState() => _ListManufacturerPageState();
}

class _ListManufacturerPageState extends State<ListManufacturerPage> {
  List<Manufacturer> activeManufacturers;
  Future<List<Manufacturer>> manufacturers;

  @override
  Widget build(BuildContext context) {
    return buildDefaultTabController();
  }

  Widget buildDefaultTabController() {
    manufacturers =
        getManufacurerList().then((value) => activeManufacturers = value);
    return FutureBuilder(
      future: manufacturers,
      builder:
          (BuildContext context, AsyncSnapshot<List<Manufacturer>> snapshot) {
        if (snapshot.hasData) {
          return DefaultTabController(
            length: snapshot.data.length, // This is the number of tabs.
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Manufacturer'),
                bottom: TabBar(
                  // These are the widgets to put in each tab in the tab bar.
                  tabs: snapshot.data
                      .map((Manufacturer manufacturer) =>
                          Tab(text: manufacturer.name))
                      .toList(),
                ),
              ),
              body: Container(
                child: TabBarView(
                  children: snapshot.data.map((Manufacturer manufacturer) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: getManufacturerPage(manufacturer),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  List<Widget> getManufacturerPage(Manufacturer manufacturer) {
    try {
      return [
        Text("Series"),
        DropdownButton(
          value: manufacturer.series[0].name,
          items: buildAndGetDropDownMenuItems(manufacturer.series),
          onChanged: (value) {
            //activeManufacturers.firstWhere((o) => o.name == value);
            print(value);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => EditProfilePage(
                      manufacturer: manufacturer,
                      serie: value,
                    )));
          },
        ),
        ElevatedButton(child: new Text("Profiles"), onPressed: () {})
      ];
    } catch (e) {
      return [Text("")];
    }
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(
      List<Serie> series) {
    List<DropdownMenuItem<String>> items = [];
    for (Serie serie in series) {
      items.add(DropdownMenuItem(
          value: serie.name,
          child: Text(serie.name + " " + (serie.isSliding ? "Sürme" : ""))));
    }
    return items;
  }

  Future<List<Manufacturer>> getManufacurerList() async {
    List<Manufacturer> result = [];
    try {
      ApiHelper api = new ApiHelper();
      var jlist = await api.getAll("manufacturer");
      print(jlist);
      List maps = jsonDecode(jlist);
      for (var item in maps) {
        var manufac = Manufacturer.fromMap(item);
        result.add(manufac);
        print(manufac);
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
