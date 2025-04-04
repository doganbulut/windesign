import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:windesign/helpers/apihelper.dart';
import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/serie.dart';
import 'package:windesign/ui/screens/profileforms/editprofilepage.dart';

class ListManufacturerPage extends StatefulWidget {
  ListManufacturerPage({Key? key}) : super(key: key);

  @override
  _ListManufacturerPageState createState() => _ListManufacturerPageState();
}

class _ListManufacturerPageState extends State<ListManufacturerPage> {
  List<Manufacturer> activeManufacturers = [];
  late Future<List<Manufacturer>> manufacturers;

  @override
  Widget build(BuildContext context) {
    return buildDefaultTabController();
  }

  Widget buildDefaultTabController() {
    manufacturers = getManufacurerList();
    return FutureBuilder(
      future: manufacturers,
      builder:
          (BuildContext context, AsyncSnapshot<List<Manufacturer>> snapshot) {
        if (snapshot.hasData) {
          activeManufacturers = snapshot.data ?? [];
          return DefaultTabController(
            length: snapshot.data!.length,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Manufacturer'),
                bottom: TabBar(
                  tabs: snapshot.data!
                      .map((Manufacturer manufacturer) =>
                          Tab(text: manufacturer.name))
                      .toList(),
                ),
              ),
              body: TabBarView(
                children: snapshot.data!.map((Manufacturer manufacturer) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: getManufacturerPage(manufacturer),
                  );
                }).toList(),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  List<Widget> getManufacturerPage(Manufacturer manufacturer) {
    try {
      return [
        const Text("Series"),
        DropdownButton(
          value: manufacturer.series.isNotEmpty
              ? manufacturer.series[0].name
              : null,
          items: buildAndGetDropDownMenuItems(manufacturer.series),
          onChanged: (value) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => EditProfilePage(
                      manufacturer: manufacturer,
                      serie: value!,
                    )));
          },
        ),
        const SizedBox.shrink()
      ];
    } catch (e) {
      print(e);
      return [const Text("Error loading data.")];
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
      ApiHelper api = ApiHelper();
      var jlist = await api.getAll("manufacturer");
      //print(jlist);
      List maps = jsonDecode(jlist);
      for (var item in maps) {
        var manufac = Manufacturer.fromMap(item);
        result.add(manufac);
        //print(manufac);
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
