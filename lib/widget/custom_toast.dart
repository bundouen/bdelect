import 'package:flutter/material.dart';
import '../constants.dart';

Widget customFToast(
  Color backgColor,
  Color colorTxt,
  Color colorIcon,
  String text,
  IconData iconData,
  ) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: backgColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, color: colorIcon),
              SizedBox(width: 12.0),
              Text(
                text,
                style: TextStyle(
                    fontFamily: khmerSiemreap,
                    package: packageKhmer,
                    color: colorTxt,
                    fontSize: 18),
              ),
            ],
          ),
        ),
      );