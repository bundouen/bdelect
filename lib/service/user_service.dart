import 'dart:convert';

import 'package:bdelect/config.dart';
import 'package:bdelect/model/otp_login_model.dart';
import 'package:get/get.dart';

import '../repository/repository.dart';

class UserService extends GetConnect {
  Repository _repository = Repository();
  UserService() {
    _repository = Repository();
  }

  Future<String> checkRegisterResult(
    String? userName,
    String? phone,
  ) async {
    try {
      Map<String, String> hearders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
      Map<String, dynamic> body = {
        "name": userName!,
        "phone": phone!,
      };

      var response = await _repository.httpPost(
        'user/checkuserphone',
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

//OTP Login
  Future<OtpLoginResponeModel> otpLogin(String mobileNo) async {
    Map<String, dynamic> body = {
      "phone": mobileNo,
    };
    Map<String, String> hearders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    // var url = Uri.http(Config.apiURL, Config.otpLoginApi);
    var respone = await _repository.httpPost("/user/otplogin", hearders, body);
    return otpLoginResponeModel(respone.body);
  }

  Future<OtpLoginResponeModel> verifyOTP(
    String mobileNo,
    String otpHash,
    String otpCode,
  ) async {
    Map<String, String> body = {
      'phone': mobileNo,
      "otp": otpCode,
      "hash": otpHash
    };
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var respone =
        await _repository.httpPost(Config.otpVerifyApi, requestHeaders, body);
    return otpLoginResponeModel(respone.body);
  }
}
