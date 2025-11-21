import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:windesign/helpers/apihelper.dart';
import 'package:windesign/profentity/manufacturer.dart';

class ManufacturerListScreen extends StatefulWidget {
  @override
  _ManufacturerListScreenState createState() => _ManufacturerListScreenState();
}

class _ManufacturerListScreenState extends State<ManufacturerListScreen> {
  late PlutoGridStateManager stateManager;
  late List<PlutoColumn> cols;
  late List<PlutoRow> rows;
  late List<Manufacturer> manufacturers;

  @override
  initState() {
    super.initState();

    cols = [
      PlutoColumn(
        title: 'Manufacturer',
        field: 'name',
        type: PlutoColumnType.text(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getManufacurerList(),
      builder: (context, AsyncSnapshot<List<Manufacturer>> snapshot) {
        if (snapshot.hasData) {
          manufacturers = snapshot.data!;
          loadRows(manufacturers);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Manufacturer'),
            ),
            body: PlutoGrid(
              columns: cols,
              rows: rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                print(event);
                event.stateManager.setSelectingMode(PlutoGridSelectingMode.row);
                stateManager = event.stateManager;
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              onSelected: (PlutoGridOnSelectedEvent event) {
                print(event);
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  List<PlutoRow> loadRows(List<Manufacturer> manufacturers) {
    rows = [];
    for (var manufacturer in manufacturers) {
      rows.add(
        PlutoRow(
          cells: {
            'name': PlutoCell(value: manufacturer.name),
          },
        ),
      );
    }
    return rows;
  }

  Future<List<Manufacturer>> getManufacurerList() async {
    List<Manufacturer> result = [];
    try {
      ApiHelper api = new ApiHelper();
      var jlist = await api.getAll("manufacturer");
      print(jlist);
      List maps = jsonDecode(jlist);
      for (var item in maps) {
        try {
          var manufac = Manufacturer.fromMap(item);
          result.add(manufac);
          print(manufac);
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
