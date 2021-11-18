import 'package:bdelect/constants.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class HomeShrimmerScreen extends StatelessWidget {
  const HomeShrimmerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
