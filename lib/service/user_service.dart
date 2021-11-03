import 'dart:convert';

import 'package:get/get.dart';

import '../repository/repository.dart';

class UserService extends GetConnect {
  Repository _repository = Repository();
  UserService() {
    _repository = Repository();
  }
// var resp = await http.post(
  //   Uri.parse('http://bdelect.bdaccessory.store/api/user/signup'),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Accept': 'application/json',

  //   },
  //   body: jsonEncode(
  //     <String, String>{
  //       'name': "Bundouen",
  //       'phone': '092575716',
  //       'password': '123456',
  //     },
  //   ),
  // );
  //
  Future<String> getRegister(
      String? userName, String? phone, String? password) async {
    try {
      Map<String, String> hearders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
      Map<String, dynamic> body = {
        "name": userName!,
        "phone": phone!,
        "password": password!,
      };

      var response = await _repository.httpPost(
        'user/signup',
        hearders,
        body,
      );
      var message = json.decode(response.body)['message'];
      // print(message);
      if (response.statusCode == 200) {
        return message;
      } else {
        throw Exception("Fail to load data");
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

//login
  Future<dynamic> getLogin(String? userOrPhone, String? password) async {
    Map<String, String> hearders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    Map<String, dynamic> body = {
      "name": userOrPhone!,
      "password": password!,
    };
    try {
      var response = await _repository.httpPost(
        '/user/login',
        hearders,
        body,
      );

      var loginResponse;
      loginResponse = json.decode(response.body);
      return loginResponse;
      // if (response.statusCode == 200) {
      //   message = json.decode(response.body);
      // }
      // else {
      //   message = json.decode(response.body)['message'];
      // }

    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
