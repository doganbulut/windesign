import 'package:http/http.dart' as http;

class ApiHelper {
  String host = "";
  String port = "";

  ApiHelper() {
    host = 'localhost';
    port = '5001';
  }
  //https://localhost:5001/api/rpc?table=manufacturer&jsondata={"name":"Egepen","series":[{"id":1,"name":"Zarizma","isSliding":false,"sashMargin":null,"profiles":[{"code":"STKFR00001","name":"Kasa","type":"frame","height":70,"topwidth":62,"width":41},{"code":"STKSH00002","name":"Kanat","type":"sash","height":70,"topwidth":58,"width":59},{"code":"STKOK00003","name":"Orta Kayıt","type":"mullion","height":70,"topwidth":82,"width":41}]}]}
  Future<bool> postTable(String table, jsondata) async {
    try {
      final url = 'https://$host:$port/api/rpc?table=$table&jsondata=$jsondata';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );

      if (response.statusCode == 200) {
        return response.body.toLowerCase() == "true";
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  //https://localhost:5001/api/rpc/GetAll/manufacturer
  Future<String> getAll(String table) async {
    try {
      final url = 'https://${host}:${port}/api/rpc/GetAll/${table}';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }
}
