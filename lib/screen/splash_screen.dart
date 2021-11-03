import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:bdelect/screen/main_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset("assets/images/bdlogo.png"),
        nextScreen: MainScreen(),
        splashTransition: SplashTransition.rotationTransition,
      ),
    );
  }
}
