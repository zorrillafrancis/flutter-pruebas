import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/response.dart';

class DataEntity {
  Future<Response> saveToken(String token, int pkidUsuario) async {
    Response res;
    final response = await http.post(
      Uri.parse(
          'https://uniformes.schoolsolutionscrm.com/api/RegistrosNotificacion'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "id": 0,
        "fecha": '2023-08-15T00:53:49.187',
        "token": token,
        "pkidusuario": pkidUsuario
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      String body = utf8.decode(response.bodyBytes);
      var jsonData = json.decode(body);
      res = Response.fromJson(jsonData);

      return res;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
