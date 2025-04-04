import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:windesign/bientity/customer.dart';
import 'package:windesign/helpers/apihelper.dart';
import 'package:windesign/helpers/gridhelper.dart';

class CustomerPageScreen extends StatefulWidget {
  static const routeName = 'add-and-remove-rows';

  @override
  _CustomerPageScreenState createState() => _CustomerPageScreenState();
}

class _CustomerPageScreenState extends State<CustomerPageScreen> {
  late List<String> fields;
  late List<PlutoColumn> cols;
  late List<PlutoRow> rows;
  late List<Customer> customers;
  late PlutoGridStateManager stateManager;

  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  @override
  void initState() {
    super.initState();

    // ignore: deprecated_member_use
    fields = [
      'code',
      'name',
      'phone',
      'fax',
      'email',
      'contactName1',
      'contactName1Phone',
      'contactName2',
      'contactName2Phone',
      'address1',
      'address2',
      'address3',
      'info1',
      'info2',
      'info3',
      'info4',
      'info5',
      'info6',
      'info7',
      'info8',
      'info9',
    ];

    Customer c1 = Customer(
      code: 'MN0001',
      name: 'Firma1 LTD ŞTİ',
      phone: '02123332211',
      fax: '',
      email: 'firma1@gmail.com',
      contactName1: "Yetkili1",
      contactName1Phone: 'Yetkili Tel 1',
      contactName2: "Yetkili2",
      contactName2Phone: 'Yetkili Tel 1',
      address1: 'address1',
      address2: 'address2',
      address3: 'address3',
      info1: "info1",
      info2: "info2",
      info3: "info3",
      info4: "info4",
      info5: "info5",
      info6: "info6",
      info7: "info7",
      info8: "info8",
      info9: "info9",
    );
    var jj = c1.toJson();
    print(jj);
  }

  void handleAddRowButton() {
    List<PlutoRow> rows = [GridHelper.rowByColumns(cols)];
    stateManager.appendRows(rows);
  }

  void handleRemoveCurrentRowButton() {
    stateManager.removeCurrentRow();
  }

  void handleRemoveSelectedRowsButton() {
    stateManager.removeRows(stateManager.currentSelectingRows);
  }

  void handleFiltering() {
    stateManager.setShowColumnFilter(!stateManager.showColumnFilter);
  }

  void setGridSelectingMode(PlutoGridSelectingMode mode) {
    if (gridSelectingMode == mode) {
      return;
    }

    setState(() {
      gridSelectingMode = mode;
      stateManager.setSelectingMode(mode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCustomerList(),
      builder: (context, AsyncSnapshot<List<Customer>> snapshot) {
        if (snapshot.hasData) {
          customers = snapshot.data!;
          loadColumns(fields);
          loadRows(customers);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Customers'),
            ),
            body: Container(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 10,
                      children: [
                        ElevatedButton(
                          child: const Text('Add a Row'),
                          onPressed: handleAddRowButton,
                        ),
                        ElevatedButton(
                          child: const Text('Remove Current Row'),
                          onPressed: handleRemoveCurrentRowButton,
                        ),
                        ElevatedButton(
                          child: const Text('Remove Selected Rows'),
                          onPressed: handleRemoveSelectedRowsButton,
                        ),
                        ElevatedButton(
                          child: const Text('Toggle filtering'),
                          onPressed: handleFiltering,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: gridSelectingMode,
                            items: PlutoGridSelectingMode.values
                                .map<DropdownMenuItem<PlutoGridSelectingMode>>(
                                    (PlutoGridSelectingMode item) {
                              final color = gridSelectingMode == item
                                  ? Colors.blue
                                  : null;

                              return DropdownMenuItem<PlutoGridSelectingMode>(
                                value: item,
                                child: Text(
                                  item.toString().split('.').last,
                                  style: TextStyle(color: color),
                                ),
                              );
                            }).toList(),
                            onChanged: (PlutoGridSelectingMode? mode) {
                              setGridSelectingMode(mode!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PlutoGrid(
                      columns: cols,
                      rows: rows,
                      onChanged: (PlutoGridOnChangedEvent event) {
                        print(event.row);
                        toCustomer(event.row);
                      },
                      onLoaded: (PlutoGridOnLoadedEvent event) {
                        stateManager = event.stateManager;
                        stateManager.setSelectingMode(gridSelectingMode);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  List<PlutoColumn> loadColumns(List<String> columns) {
    cols = [];
    for (var column in columns) {
      cols.add(
        PlutoColumn(
          title: column,
          field: column,
          type: PlutoColumnType.text(),
        ),
      );
    }
    return cols;
  }

  Customer toCustomer(PlutoRow row) {
    return new Customer(
      code: row.cells['code']?.value,
      name: row.cells['name']?.value,
      phone: row.cells['phone']?.value,
      fax: row.cells['fax']?.value,
      email: row.cells['email']?.value,
      contactName1: row.cells['contactName1']?.value,
      contactName1Phone: row.cells['contactName1Phone']?.value,
      contactName2: row.cells['contactName2']?.value,
      contactName2Phone: row.cells['contactName2Phone']?.value,
      address1: row.cells['address1']?.value,
      address2: row.cells['address2']?.value,
      address3: row.cells['address3']?.value,
      info1: row.cells['info1']?.value,
      info2: row.cells['info2']?.value,
      info3: row.cells['info3']?.value,
      info4: row.cells['info4']?.value,
      info5: row.cells['info5']?.value,
      info6: row.cells['info6']?.value,
      info7: row.cells['info7']?.value,
      info8: row.cells['info8']?.value,
      info9: row.cells['info9']?.value,
    );
  }

  List<PlutoRow> loadRows(List<Customer> customers) {
    rows = [];
    for (var customer in customers) {
      rows.add(
        PlutoRow(
          cells: {
            'code': PlutoCell(value: customer.code),
            'name': PlutoCell(value: customer.name),
            'phone': PlutoCell(value: customer.phone),
            'fax': PlutoCell(value: customer.fax),
            'email': PlutoCell(value: customer.email),
            'contactName1': PlutoCell(value: customer.contactName1),
            'contactName1Phone': PlutoCell(value: customer.contactName1Phone),
            'contactName2': PlutoCell(value: customer.contactName2),
            'contactName2Phone': PlutoCell(value: customer.contactName2Phone),
            'address1': PlutoCell(value: customer.address1),
            'address2': PlutoCell(value: customer.address2),
            'address3': PlutoCell(value: customer.address3),
            'info1': PlutoCell(value: customer.info1),
            'info2': PlutoCell(value: customer.info2),
            'info3': PlutoCell(value: customer.info3),
            'info4': PlutoCell(value: customer.info4),
            'info5': PlutoCell(value: customer.info5),
            'info6': PlutoCell(value: customer.info6),
            'info7': PlutoCell(value: customer.info7),
            'info8': PlutoCell(value: customer.info8),
            'info9': PlutoCell(value: customer.info9),
          },
        ),
      );
    }
    return rows;
  }

  Future<List<Customer>> getCustomerList() async {
    List<Customer> result = [];
    try {
      ApiHelper api = new ApiHelper();
      var jlist = await api.getAll("customer");
      print(jlist);
      List maps = jsonDecode(jlist);
      for (var item in maps) {
        try {
          var cust = Customer.fromMap(item);
          result.add(cust);
          print(cust);
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
