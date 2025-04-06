import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  final String host;
  final String port;

  ApiHelper({this.host = 'localhost', this.port = '5001'});

  Future<bool> postTable(String table, Map<String, dynamic> jsonData) async {
    try {
      final uri = Uri.https(host, '/api/rpc', {'table': table});

      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        return response.body.toLowerCase() == "true";
      } else {
        throw Exception(
            'Failed to post data to table $table. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error posting data to table $table: $e');
      return false;
    }
  }

  Future<String> getAll(String table) async {
    try {
      final uri = Uri.https(host, '/api/rpc/GetAll/$table');

      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception(
            'Failed to get data from table $table. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error getting data from table $table: $e');
      return "";
    }
  }
}
