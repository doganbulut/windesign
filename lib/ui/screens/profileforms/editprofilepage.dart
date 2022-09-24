import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:editable/editable.dart';
import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/serie.dart';

class EditProfilePage extends StatefulWidget {
  Manufacturer manufacturer;
  String serie;
  EditProfilePage({Key key, this.manufacturer, this.serie}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  /// Create a Key for EditableState
  final _editableKey = GlobalKey<EditableState>();

  List cols = [
    {"title": 'Code', 'key': 'code'},
    {"title": 'Name', 'key': 'name'},
    {"title": 'Type', 'key': 'type'},
    {"title": 'Height', 'key': 'height'},
    {"title": 'Topwidth', 'key': 'topwidth'},
    {"title": 'Width', 'key': 'width'},
  ];

  List rows = [
    {
      "code": "STKFR00001",
      "name": "Kasa",
      "type": "frame",
      "height": "70",
      "topwidth": "62",
      "width": "41"
    }
  ];

  void _addNewRow() {
    setState(() {
      _editableKey.currentState.createRow();
    });
  }

  ///Print only edited rows.
  void _printEditedRows() {
    List editedRows = _editableKey.currentState.editedRows;
    print(editedRows);
  }

  @override
  Widget build(BuildContext context) {
    var profiles = widget.manufacturer.series
        .firstWhere((e) => e.name == widget.serie)
        .profiles;

    rows.clear();

    for (var profile in profiles) {
      rows.add(profile.toMap());
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: FlatButton.icon(
            onPressed: () => _addNewRow(),
            icon: Icon(Icons.add),
            label: Text(
              'Add',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        title: Text("Profiles"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () => _printEditedRows(),
                child: Text('Print Edited Rows',
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
        },
        onSubmitted: (value) {
          print(value);
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
