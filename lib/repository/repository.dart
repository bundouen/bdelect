import 'dart:convert';

import '../constants.dart';
import 'package:http/http.dart' as http;

class Repository {
  //
  // String _baseUrl = urlPath;

  httpGet(String api) async {
    // print(Uri.parse(_baseUrl + api));
    return await http.get(Uri.parse(urlPath + api));
  }

  httpPost(
      String api, Map<String, String> headers, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse(urlPath + api),
      headers: headers,
      body: jsonEncode(body),
    );
  }
}
