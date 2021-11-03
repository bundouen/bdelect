import 'package:bdelect/controller/user_controller.dart';
import 'package:bdelect/screen/Authform/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:http/http.dart' as http;

Widget shoppingCartIcon(Icon icon) {
  final UserController userController = Get.find<UserController>();

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox.fromSize(
      size: Size(40, 30), // button width and height

      child: ClipOval(
        child: Material(
          color: Colors.white, // button color

          child: InkWell(
            splashColor: Colors.green, // splash color
            onTap: () async {
              if (userController.box.read("logged") == null) {
                Get.toNamed(LoginScreen.routeName);
              }
            }, // button pressed

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[icon],
            ),
          ),
        ),
      ),
    ),
  );
}
