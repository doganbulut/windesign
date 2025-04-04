import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:windesign/helpers/apihelper.dart';
import 'package:windesign/profentity/manufacturer.dart';
import 'package:windesign/profentity/serie.dart';
import 'package:windesign/ui/localization/languagehelper.dart';
import 'package:windesign/ui/screens/profileforms/listmanufacturerpage.dart';

class AddManufacturerPage extends StatefulWidget {
  const AddManufacturerPage({Key? key}) : super(key: key);

  @override
  _AddManufacturerPageState createState() => _AddManufacturerPageState();
}

class _AddManufacturerPageState extends State<AddManufacturerPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> response = {};

  List<Map<String, dynamic>> formFields = [
    {
      "name": "name",
      "label": LngHelper().words.lblManufacturerInfo,
      "type": "text",
      "required": true,
    },
  ];

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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    for (var field in formFields) _buildFormField(field),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: Text(LngHelper().words.lblSave),
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          response = _formKey.currentState!.value;
                          createData(response);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text(LngHelper().words.lblManufacturerList),
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => ListManufacturerPage()));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(Map<String, dynamic> field) {
    String fieldName = field['name'];
    String fieldType = field['type'];
    String label = field['label'];
    bool isRequired = field['required'] ?? false;

    switch (fieldType) {
      case 'text':
        return FormBuilderTextField(
          name: fieldName,
          decoration: InputDecoration(labelText: label),
          validator: isRequired
              ? FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ])
              : null,
        );
      // Add more field types (number, dropdown, etc.) here as needed
      default:
        return const SizedBox.shrink();
    }
  }

  createData(Map<String, dynamic> response) async {
    try {
      if (response.containsKey('name')) {
        Manufacturer manufacturer =
            Manufacturer(name: response['name'], series: <Serie>[]);
        ApiHelper api = ApiHelper();
        if (await api.postTable('manufacturer', manufacturer.toJson())) {
          // Optionally, you can add success handling here, like showing a snackbar
          print('Manufacturer created successfully!');
        }
      }
    } catch (e) {
      print('Error creating manufacturer: $e');
    }
  }
}
