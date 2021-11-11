import 'package:bdelect/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //  await GetStorage.init();
  runApp(SplashScreen());
}
