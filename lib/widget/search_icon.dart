import 'package:bdelect/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget seachIcon(Icon icon) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox.fromSize(
        size: Size(40, 30), // button width and height

        child: ClipOval(
          child: Material(
            color: Colors.white, // button color

            child: InkWell(
              splashColor: Colors.green, // splash color

              onTap: () {
                Get.toNamed(SearchScreen.routeName);
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
