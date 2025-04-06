import 'dart:async';
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
  PlutoGridStateManager? stateManager;
  List<PlutoColumn>? cols;
  List<PlutoRow>? rows;
  List<Manufacturer>? manufacturers;
  final String manufacturerEndpoint = "manufacturer";

  @override
  void initState() {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manufacturer'),
      ),
      body: FutureBuilder<List<Manufacturer>>(
        future: getManufacurerList(),
        builder: (context, AsyncSnapshot<List<Manufacturer>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            manufacturers = snapshot.data;
            rows = loadRows(manufacturers!);
            return PlutoGrid(
              columns: cols!,
              rows: rows!,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                event.stateManager.setSelectingMode(PlutoGridSelectingMode.row);
                stateManager = event.stateManager;
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              onSelected: (PlutoGridOnSelectedEvent event) {
                print(event);
              },
            );
          } else {
            return Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }

  List<PlutoRow> loadRows(List<Manufacturer> manufacturers) {
    return manufacturers.map((manufacturer) {
      return PlutoRow(
        cells: {
          'name': PlutoCell(value: manufacturer.name),
        },
      );
    }).toList();
  }

  Future<List<Manufacturer>> getManufacurerList() async {
    List<Manufacturer> result = [];
    try {
      ApiHelper api = ApiHelper();
      var jsonResponse = await api.getAll(manufacturerEndpoint);
      print(jsonResponse);
      List maps = jsonDecode(jsonResponse);
      for (var item in maps) {
        try {
          var manufac = Manufacturer.fromMap(item);
          result.add(manufac);
          print(manufac);
        } on FormatException catch (e) {
          print('JSON parsing error: $e');
          // Handle JSON parsing error
        } catch (e) {
          print('Error processing item: $e');
          // Handle other errors
        }
      }
    } on TimeoutException catch (e) {
      print('Request timed out: $e');
      // Handle timeout
    } catch (e) {
      print('An unexpected error occurred: $e');
      // Handle other errors
    }
    return result;
  }
}
