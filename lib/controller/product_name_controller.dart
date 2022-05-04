import 'dart:convert';

import 'package:bdelect/model/pname.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ProductNameController extends GetxController {
  var productNameList = <PName>[].obs;

  Future<List<PName>> getUserSuggestions(String query) async {
    final url = Uri.parse(
      'http://bdelect.bdaccessory.store/api/product/distinctproduct',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List pnames = json.decode(response.body);
      return pnames.map((json) => PName.fromJson(json)).where((pname) {
        final nameLower = pname.name.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
