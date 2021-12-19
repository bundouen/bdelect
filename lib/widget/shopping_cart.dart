import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;

Widget shoppingCartIcon(Icon icon) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox.fromSize(
      size: Size(40, 40), // button width and height

      child: ClipOval(
        child: Material(
          color: Colors.white,
          child: InkWell(
            splashColor: Colors.green, // splash color
            onTap: () async {
              // if (userController.box.read("logged") == null) {
              //   Get.toNamed(LoginScreen.routeName);
              // }
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
