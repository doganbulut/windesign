import 'package:flutter/material.dart';
import 'package:editable/editable.dart';
import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/serie.dart';

class EditProfilePage extends StatefulWidget {
  final Manufacturer manufacturer;
  final String serie;
  const EditProfilePage(
      {Key? key, required this.manufacturer, required this.serie})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _editableKey = GlobalKey<EditableState>();

  List<Map<String, String>> cols = [
    {"title": 'Code', "key": 'code'},
    {"title": 'Name', "key": 'name'},
    {"title": 'Type', "key": 'type'},
    {"title": 'Height', "key": 'height'},
    {"title": 'Topwidth', "key": 'topwidth'},
    {"title": 'Width', "key": 'width'},
  ];

  List<Map<String, dynamic>> rows = [];

  void _addNewRow() {
    setState(() {
      _editableKey.currentState?.createRow();
    });
  }

  void _printEditedRows() {
    List editedRows = _editableKey.currentState?.editedRows ?? [];
    print(editedRows);
  }

  @override
  Widget build(BuildContext context) {
    final serie = widget.manufacturer.series.firstWhere(
      (e) => e.name == widget.serie,
      orElse: () =>
          Serie(name: '', profiles: [], isSliding: false, sashMargin: 0),
    );

    rows = serie.profiles.map((profile) => profile.toMap()).toList();

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: TextButton.icon(
            onPressed: _addNewRow,
            icon: const Icon(Icons.add),
            label: const Text(
              'Add',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        title: const Text("Profiles"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: _printEditedRows,
                child: const Text('Print Edited Rows',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          )
        ],
      ),
      body: Editable(
        key: _editableKey,
        columns: cols,
        rows: rows,
        onRowSaved: (value) {
          print(value);
          //TODO: Save data
        },
        onSubmitted: (value) {
          print(value);
          //TODO: Save data
        },
        thAlignment: TextAlign.center,
        thPaddingBottom: 3,
        showSaveIcon: true,
        saveIconColor: Colors.black,
        showCreateButton: true,
        tdAlignment: TextAlign.left,
        tdPaddingLeft: 10,
        tdPaddingRight: 10,
      ),
    );
  }
}
