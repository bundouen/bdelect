import 'dart:convert';

import '../repository/repository.dart';

class CsrfTokenService {
  Repository _repository = Repository();
  CsrfTokenService() {
    _repository = Repository();
  }
  Future<String> getCsrfToken() async {
    try {
      var response = await _repository.httpGet('user/crsftoken');
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var csrfToken = json.decode(jsonString)['csrfToken'];
        return csrfToken;
      } else {
        return "No csrfToken";
      }
    } catch (err) {
      throw err;
    }
  }
}
