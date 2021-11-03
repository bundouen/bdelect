// ignore_for_file: unused_local_variable

import 'package:bdelect/model/login.dart';
import 'package:bdelect/service/user_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  UserService _userService = UserService();
  var isLoggedIn = true.obs;
  // var isRegister = false.obs;
  var loggedStatus = "";
  var msgRegistered = "";
  var msgLoggedIn = "";

  var box = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }
  

//Register
  Future<String> fetchRegister(
    String userName,
    String phone,
    String password,
  ) async {
    try {
      var resp = await _userService.getRegister(
        userName,
        phone,
        password,
      );
      if (resp == 'true') {
        msgRegistered = "​បង្កើតគនេយ្យបានជោគជ័យ";
        return 'true';
      } else if (resp == 'name') {
        msgRegistered = "​ឈ្មោះ​មានម្តងហើយ!";
        return 'name';
      } else if (resp == 'phone') {
        msgRegistered = "​លេខទូរស័រព្ទមានម្តងហើយ!";
        return 'phone';
      } else if (resp == 'false') {
        msgRegistered = "​ឈ្មោះនិងលេខទូរស័រព្ទ មានម្តងហើយ!";
        return 'false';
      } else {
        msgRegistered = "​មានបញ្ហា...!!!";
        return ('error');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

//LogIn
  Future<String> fetchLogin(
    String userName,
    String password,
  ) async {
    try {
      var resp = await _userService.getLogin(
        userName,
        password,
      );
      // print(resp['message']);
      var msgStatus = resp['message'];
      if (msgStatus == 'ok') {
        msgLoggedIn = "​ជោគជ័យ";
        box.write("logged", resp);
        isLoggedIn.value = false;
        return msgStatus;
      } else if (msgStatus == 'erroruser') {
        msgLoggedIn = "​ឈ្មោះ​/លេខទូរស័ព្ទមិនមានទេ!";
        isLoggedIn.value = false;
        return msgStatus;
      } else if (msgStatus == 'errorpass') {
        msgLoggedIn = "​លេខសម្ងាត់មិនត្រឹមត្រូវ!";
        isLoggedIn.value = false;
        return msgStatus;
      } else {
        msgRegistered = "​មានបញ្ហា...!!!";
        return "";
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Login? getLoggedIn() {
    if (box.read('logged') != null) {
      return box.read("logged");
    } else {
      return null;
    }
  }

  void getLogOut() {
    box.remove("logged");
  }
}
