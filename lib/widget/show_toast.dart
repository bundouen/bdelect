import 'package:bdelect/widget/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  FToast fToast;
  ShowToast(this.fToast);
  void showFlutterToast(Color backgColor, Color colorTxt, Color colorIcon,
          String text, IconData iconData) =>
      fToast.showToast(
        child: customFToast(backgColor, colorTxt, colorIcon, text, iconData),
        gravity: ToastGravity.TOP,
        // positionedToastBuilder: (context, child) =>
        //     Positioned(child: child, top: 150, left: 0, right: 0),
      );
}
