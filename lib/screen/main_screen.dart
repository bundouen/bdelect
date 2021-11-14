
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';

import '/binding/home_binding.dart';
import '/constants.dart';
import 'Authform/login_screen.dart';
import 'Authform/registration_screen.dart';
import 'product_by_brand_screen.dart';
import 'product_by_category_screen.dart';
import 'product_by_group_screen.dart';
import 'search_screen.dart';
import '/widget/product_detail/product_detail_view.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: HomeBinding(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme().apply(displayColor: kTextColor),
          appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: HomeView(),
    
        initialRoute: HomeView.routName,
    
        getPages: [
          GetPage(
              name: HomeView.routName,
              page: () => HomeView(),
              binding: HomeBinding()),
          GetPage(
            name: ProductDetails.routeName,
            page: () => ProductDetails(),
          ),
          GetPage(
            name: ProductByGroupScreen.routeName,
            page: () => ProductByGroupScreen(),
          ),
          GetPage(
            name: ProductByCategoryScreen.routeName,
            page: () => ProductByCategoryScreen(),
          ),
          GetPage(
            name: ProductByBrandScreen.routeName,
            page: () => ProductByBrandScreen(),
          ),
          GetPage(
            name: SearchScreen.routeName,
            page: () => SearchScreen(),
          ),
          GetPage(
            name: LoginScreen.routeName,
            page: () => LoginScreen(),
          ),
          GetPage(
            name: RegistrationScreen.routeName,
            page: () => RegistrationScreen(),
          ),
          
        ],
      ),
    );
  }
}
