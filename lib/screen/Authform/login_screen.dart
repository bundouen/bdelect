import 'dart:ui';

import 'package:bdelect/constants.dart';
import 'package:bdelect/controller/productcontroller.dart';
// import 'package:bdelect/controller/productcontroller.dart';
import 'package:bdelect/controller/user_controller.dart';

import 'package:bdelect/screen/Authform/registration_screen.dart';
import 'package:bdelect/screen/home_screen.dart';
import 'package:bdelect/screen/main_screen.dart';
import 'package:bdelect/widget/custom_toast.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final UserController _userController = Get.find<UserController>();

  FocusNode nodeName = FocusNode();
  FocusNode nodePass = FocusNode();
  bool colorName = true;
  bool colorPass = true;
  bool isApiCallProcess = false;

  bool hidePass = true;
  final fToast = FToast();

  @override
  void initState() {
    fToast.init(context);
    nameController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      autofocus: true,
      focusNode: nodeName,
      controller: nameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("បញ្ជូល ឈ្មោះ​​/លេខទូរស័ព្ទ");
        }
        if (!regex.hasMatch(value)) {
          return ("បញ្ជូលឈ្មោះមិនត្រឹមត្រូវ(យ៉ាងតិច​ ៣ អក្សរ)");
        }

        return null;
      },
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorName ? Colors.blue : Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(Icons.account_circle),
        suffixIcon: nameController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                onPressed: () {
                  nameController.clear();
                },
                icon: Icon(Icons.clear),
              ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        // hintText: "ឈ្មោះ",
        labelText: "ឈ្មោះ​/លេខទូរស័ព្ទ",
        labelStyle: new TextStyle(
          fontFamily: khmerSiemreap,
          package: packageKhmer,
        ),
        errorStyle: new TextStyle(
          fontFamily: khmerSiemreap,
          package: packageKhmer,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );

// // FielName
    // final nameField = TextFormField(
    //   autofocus: false,
    //   focusNode: nodeName,
    //   controller: nameController,
    //   keyboardType: TextInputType.name,
    //   style: new TextStyle(
    //     // fontFamily: khmerSiemreap,
    //     // package: packageKhmer,
    //     fontSize: 18,
    //   ),
    //   validator: (value) {
    //     if (value!.isEmpty) {
    //       return ("បញ្ជូល ឈ្មោះ​​/លេខទូរស័ព្ទ");
    //     }
    //     // // reg expression for email validation
    //     // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
    //     //     .hasMatch(value)) {
    //     //   return ("Please Enter a valid email");
    //     // }
    //     return null;
    //   },
    //   onSaved: (value) {
    //     nameController.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.person),
    //     contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //     // hintText: "ឈ្មោះ​/លេខទូរស័ព្ទ",
    //     labelText: "ឈ្មោះ​/លេខទូរស័ព្ទ",
    //     errorStyle: new TextStyle(
    //       fontFamily: khmerSiemreap,
    //       package: packageKhmer,
    //     ),
    //     labelStyle: new TextStyle(
    //       fontFamily: khmerSiemreap,
    //       package: packageKhmer,
    //     ),
    //     enabledBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: Colors.grey),
    //       borderRadius: BorderRadius.circular(30),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(
    //         color: colorName ? Colors.blue : Colors.red,
    //         width: 2,
    //       ),
    //       borderRadius: BorderRadius.circular(30),
    //     ),
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(30),
    //     ),
    //   ),
    // );

// // PASSWORD FIELD
    // final passwordField = TextFormField(
    //   autofocus: false,
    //   focusNode: nodePass,
    //   controller: passwordController,
    //   obscureText: hidePass,
    //   validator: (value) {
    //     RegExp regex = new RegExp(r'^.{6,}$');
    //     if (value!.isEmpty) {
    //       return ("បញ្ជូលលេខសម្ងាត់");
    //     }
    //     if (!regex.hasMatch(value)) {
    //       return ("លេខសម្ងាត់មិនត្រឹមត្រូវ(យ៉ាងតិច 6 អក្សរ)");
    //     }
    //   },
    //   onSaved: (value) {
    //     passwordController.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.vpn_key),
    //     suffixIcon: IconButton(
    //       onPressed: () {
    //         setState(() {
    //           hidePass = !hidePass;
    //         });
    //       },
    //       icon: Icon(
    //         hidePass ? Icons.visibility_off : Icons.visibility,
    //       ),
    //     ),
    //     contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //     // hintText: "លេខសម្ងាត់",
    //     labelText: "លេខសម្ងាត់",
    //     errorStyle: new TextStyle(
    //       fontFamily: khmerSiemreap,
    //       package: packageKhmer,
    //     ),
    //     labelStyle: new TextStyle(
    //       fontFamily: khmerSiemreap,
    //       package: packageKhmer,
    //     ),
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(30),
    //     ),
    //   ),
    // );

    //  // password field
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      focusNode: nodePass,
      controller: passwordController,
      keyboardType: TextInputType.name,
      style: new TextStyle(
        fontSize: 18,
        // fontFamily: khmerSiemreap,
        // package: packageKhmer,
      ),
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("បញ្ជូលលេខសម្ងាត់!");
        }
        if (!regex.hasMatch(value)) {
          return ("លេខសម្ងាត់មិនត្រឹមត្រូវ(យ៉ាងតិច 6 អក្សរ)");
        }

        return null;
      },
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        // hintText: "ឈ្មោះ​/លេខទូរស័ព្ទ",
        labelText: "លេខសម្ងាត់",
        errorStyle: new TextStyle(
          fontFamily: khmerSiemreap,
          package: packageKhmer,
        ),
        labelStyle: new TextStyle(
          fontFamily: khmerSiemreap,
          package: packageKhmer,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorPass ? Colors.blue : Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,

      borderRadius: BorderRadius.circular(30),
      color: kPrimaryColor, //Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(nameController.text, passwordController.text, MainScreen());
        },
        child: Text(
          "ចូលប្រើប្រាស់",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            fontFamily: khmerMoul,
            package: packageKhmer,
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          key: UniqueKey(),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/images/bdlogo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 20),
                        nameField,
                        SizedBox(height: 20),
                        passwordField,
                        SizedBox(height: 20),
                        loginButton,
                        SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "មិនទាន់បានចុះឈ្មោះ? ",
                                style: TextStyle(
                                  fontFamily: khmerSiemreap,
                                  package: packageKhmer,
                                  fontSize: 15,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RegistrationScreen.routeName);
                                },
                                child: Text(
                                  "ចុះឈ្មោះ",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: khmerMoul,
                                      package: packageKhmer,
                                      fontSize: 16),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String name, String password, Widget page) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isApiCallProcess = true;
      });
      var loggedStatus = await _userController.fetchLogin(name, password);
      if (loggedStatus == "ok") {
        setState(() {
          isApiCallProcess = false;
        });
        showFlutterToast(Colors.indigo, kSecondaryColor, kSecondaryColor,
            _userController.msgLoggedIn, Icons.check);
        print(_userController.box.read('logged'));

        Get.delete<ProductController>();
        Get.offNamedUntil(HomeView.routName, (route) => false);
      } else if (loggedStatus == "erroruser") {
        showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
            _userController.msgLoggedIn, Icons.close);
        setState(() {
          colorName = false;
          isApiCallProcess = false;
        });
        nodeName.requestFocus();
      } else if (loggedStatus == "errorpass") {
        showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
            _userController.msgLoggedIn, Icons.close);
        nodePass.requestFocus();
        setState(() {
          colorPass = false;
          isApiCallProcess = false;
        });
      } else {
        showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
            _userController.msgLoggedIn, Icons.close);
        nodePass.requestFocus();
        setState(() {
          colorPass = false;
          colorName = false;
          isApiCallProcess = false;
        });
      }
    }
  }

  void showFlutterToast(Color backgColor, Color colorTxt, Color colorIcon,
          String text, IconData iconData) =>
      fToast.showToast(
        child: customFToast(backgColor, colorTxt, colorIcon, text, iconData),
        gravity: ToastGravity.TOP,
        // positionedToastBuilder: (context, child) =>
        //     Positioned(child: child, top: 150, left: 0, right: 0),
      );
}
