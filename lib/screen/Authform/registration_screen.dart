import 'package:bdelect/constants.dart';

import 'package:bdelect/controller/user_controller.dart';
import 'package:bdelect/screen/Authform/otp_screen.dart';

import 'package:bdelect/widget/custom_toast.dart';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = "/register";
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // final _auth = FirebaseAuth.instance;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final fToast = FToast();
  final UserController _userController =
      Get.put<UserController>(UserController());
  // final UserService _userService = UserService();
  bool hidePass = true;
  bool hideConPass = true;
  FocusNode nodeName = FocusNode();
  FocusNode nodePhone = FocusNode();
  bool colorName = true;
  bool colorPhone = true;

  int minNumber = 1000;
  int maxNumber = 6000;

  bool isApiCallProcess = false;
  @override
  void initState() {
    fToast.init(context);
    firstNameEditingController.addListener(() => setState(() {}));
    phoneEditingController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //first name field

    final firstNameField = TextFormField(
        autofocus: true,
        focusNode: nodeName,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("បញ្ជូលឈ្មោះ");
          }
          if (!regex.hasMatch(value)) {
            return ("បញ្ជូលឈ្មោះមិនត្រឹមត្រូវ(យ៉ាងតិច​ ៣ អក្សរ)");
          }
          // if (colorName == false) {
          //   return ("Already Exist");
          // }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
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
          suffixIcon: firstNameEditingController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  onPressed: () {
                    firstNameEditingController.clear();
                  },
                  icon: Icon(Icons.clear),
                ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          // hintText: "ឈ្មោះ",
          labelText: "ឈ្មោះ",
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
        ));

    //second name field
    final phoneNameField = TextFormField(
      autofocus: false,
      focusNode: nodePhone,
      controller: phoneEditingController,
      keyboardType: TextInputType.number,
      validator: (value) {
        // if (value!.isEmpty) {
        //   return ("Second Name cannot be Empty");
        // }
        // String patttern = r'(^(?:[+0]9)?[0-9]{9,10}$)';
        // RegExp regExp = new RegExp(patttern);
        if (value!.length == 0) {
          return 'បញ្ជូលលេខទូរស័ព្ទ';
        }
        // if (!regExp.hasMatch(value)) {
        //   return 'លេខទូរស័ព្ទមិនត្រឹមត្រូវ';
        // }
        // if (colorPhone == false) {
        //   return ("Already Exist");
        // }
        return null;
      },
      onSaved: (value) {
        phoneEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorPhone ? Colors.blue : Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(Icons.phone),
        suffixIcon: phoneEditingController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                onPressed: () {
                  phoneEditingController.clear();
                },
                icon: Icon(Icons.clear),
              ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        // hintText: "លេខទូរស័ព្ទ",
        labelText: "លេខទូរស័ព្ទ",
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

    // //email field
    // final emailField = TextFormField(
    //   autofocus: false,
    //   controller: emailEditingController,
    //   keyboardType: TextInputType.emailAddress,
    //   validator: (value) {
    //     if (value!.isEmpty) {
    //       return ("Please Enter Your Email");
    //     }
    //     // reg expression for email validation
    //     if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
    //       return ("Please Enter a valid email");
    //     }
    //     return null;
    //   },
    //   onSaved: (value) {
    //     firstNameEditingController.text = value!;
    //   },
    //   textInputAction: TextInputAction.next,
    //   decoration: InputDecoration(
    //     prefixIcon: Icon(Icons.mail),
    //     contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //     hintText: "អុីម៉ែល(Email)",
    //     hintStyle: new TextStyle(
    //       fontFamily: khmerSiemreap,
    //       package: packageKhmer,
    //     ),
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //   ),
    // );

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: hidePass,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("បញ្ជូលលេខសម្ងាត់");
          }
          if (!regex.hasMatch(value)) {
            return ("លេខសម្ងាត់មិនត្រឹមត្រូវ(យ៉ាងតិច 6 អក្សរ)");
          }
        },
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePass = !hidePass;
              });
            },
            icon: Icon(
              hidePass ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          // hintText: "លេខសម្ងាត់",
          labelText: "លេខសម្ងាត់",
          errorStyle: new TextStyle(
            fontFamily: khmerSiemreap,
            package: packageKhmer,
          ),
          labelStyle: new TextStyle(
            fontFamily: khmerSiemreap,
            package: packageKhmer,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: hideConPass,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "លេខសម្ងាត់មិនដូចគ្នា";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hideConPass = !hideConPass;
            });
          },
          icon: Icon(
            hideConPass ? Icons.visibility_off : Icons.visibility,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        // hintText: "បញ្ចាក់លេខសម្ងាត់",
        labelText: "បញ្ចាក់លេខសម្ងាត់",
        errorStyle: new TextStyle(
          fontFamily: khmerSiemreap,
          package: packageKhmer,
        ),
        labelStyle: new TextStyle(
          fontFamily: khmerSiemreap,
          package: packageKhmer,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: kPrimaryColor, //Colors.redAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(
              firstNameEditingController.text,
              int.parse(phoneEditingController.text),
              passwordEditingController.text,
            );
          },
          child: Text(
            "ចុះឈ្មោះ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              // fontWeight: FontWeight.bold,
              fontFamily: khmerMoul,
              package: packageKhmer,
            ),
          )),
    );

    return KeyboardDismisser(
      gestures: [
        GestureType.onTap,
      ],
      child: GestureDetector(
        // onTap: () => FocusScope.of(context).requestFocus(FocusNode(),),
        child: Scaffold(
          backgroundColor: kSecondaryColor,
          appBar: AppBar(
            backgroundColor: kSecondaryColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: kPrimaryColor),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: ProgressHUD(
            inAsyncCall: isApiCallProcess,
            key: UniqueKey(),
            opacity: 0.3,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  color: kSecondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: 180,
                              child: Image.asset(
                                "assets/images/bdlogo.png",
                                fit: BoxFit.contain,
                              )),
                          SizedBox(height: 15),
                          firstNameField,
                          SizedBox(height: 20),
                          phoneNameField,
                          // SizedBox(height: 20),
                          // emailField,
                          SizedBox(height: 20),
                          passwordField,
                          SizedBox(height: 20),
                          confirmPasswordField,
                          SizedBox(height: 20),
                          signUpButton,
                          SizedBox(height: 15),

                          // FirebasePhoneAuthHandler(
                          //   phoneNumber: "+85592575716",
                          //   builder: (context, controller) {
                          //     return SizedBox.shrink();
                          //   },
                          //   onLoginSuccess: (userCredential, autoVerified) {
                          //     print("autoVerified: $autoVerified");
                          //     print(
                          //         "Login success UID: ${userCredential.user?.uid}");
                          //   },
                          //   onLoginFailed: (authException) {
                          //     print(
                          //         "An error occurred: ${authException.message}");
                          //   },
                          // ),
                        ],
                      ),
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

  void signUp(
    String userName,
    int phone,
    String password,
  ) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isApiCallProcess = true;
      });
      String fPhone = "+855$phone";
      var result =
          await _userController.fetchCheckRegisterResult(userName, fPhone);
      print(result);
      if (result == "true") {
        // showFlutterToast(Colors.indigo, kSecondaryColor, kSecondaryColor,
        //     _userController.msgRegistered, Icons.check);
        setState(() {
          isApiCallProcess = false;
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => OTPScreen(
              phone: fPhone,
              userName: userName,
              password: password,
            ),
          ),
        );
      } else if (result == 'name') {
        showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
            _userController.msgRegistered, Icons.close);
        // firstNameEditingController.text = "";
        // FocusScope.of(context).requestFocus(nodeName);
        nodeName.requestFocus();
        setState(() {
          colorName = false;
          isApiCallProcess = false;
        });
      } else if (result == 'phone') {
        showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
            _userController.msgRegistered, Icons.close);
        nodePhone.requestFocus();
        setState(() {
          colorPhone = false;
          isApiCallProcess = false;
        });
      } else if (result == 'false') {
        showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
            _userController.msgRegistered, Icons.close);
        // firstNameEditingController.clear();
        // phoneEditingController.clear();
        nodeName.requestFocus();
        setState(() {
          colorName = false;
          colorPhone = false;
          isApiCallProcess = false;
        });
      } else {
        showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
            _userController.msgRegistered, Icons.close);
        phoneEditingController.text = "";
        setState(() {
          isApiCallProcess = false;
        });
      }
    } else {
      showFlutterToast(kPrimaryColor, kSecondaryColor, kSecondaryColor,
          "បំពេញមិនបានត្រឹមត្រូវ..!", Icons.edit_off);
      setState(() {
        isApiCallProcess = false;
      });
    }
  }

  // _userService.otpLogin(phone).then((respone) async {
  //   setState(() {
  //     isApiCallProcess = false;
  //   });
  //   if (respone.data != null) {
  //     print(respone.message);
  //     print(respone.data);

  //     Get.off(
  //       () => OtpVerifyPage(
  //         mobileNo: phone,
  //         otpHash: respone.data,
  //       ),
  //     );
  //   }
  // });

  //     var result =
  //         await _userController.fetchRegister(userName, phone, password);
  //     if (result == "true") {
  //       showFlutterToast(Colors.indigo, kSecondaryColor, kSecondaryColor,
  //           _userController.msgRegistered, Icons.check);
  //       setState(() {
  //         isApiCallProcess = false;
  //       });
  //       Get.offNamed(LoginScreen.routeName);
  //     } else if (result == 'name') {
  //       showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
  //           _userController.msgRegistered, Icons.close);
  //       // firstNameEditingController.text = "";
  //       // FocusScope.of(context).requestFocus(nodeName);
  //       nodeName.requestFocus();
  //       setState(() {
  //         colorName = false;
  //         isApiCallProcess = false;
  //       });
  //     } else if (result == 'phone') {
  //       showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
  //           _userController.msgRegistered, Icons.close);
  //       // phoneEditingController.text = "";
  //       nodePhone.requestFocus();
  //       setState(() {
  //         colorPhone = false;
  //         isApiCallProcess = false;
  //       });
  //     } else if (result == 'false') {
  //       showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
  //           _userController.msgRegistered, Icons.close);
  //       // firstNameEditingController.clear();
  //       // phoneEditingController.clear();
  //       nodeName.requestFocus();
  //       setState(() {
  //         colorName = false;
  //         colorPhone = false;
  //         isApiCallProcess = false;
  //       });
  //     } else {
  //       showFlutterToast(kRColor, kSecondaryColor, kSecondaryColor,
  //           _userController.msgRegistered, Icons.close);
  //       phoneEditingController.text = "";
  //       setState(() {
  //         isApiCallProcess = false;
  //       });
  //     }
  //   } else {
  //     showFlutterToast(kPrimaryColor, kSecondaryColor, kSecondaryColor,
  //         "បំពេញមិនបានត្រឹមត្រូវ..!", Icons.edit_off);
  //     setState(() {
  //       isApiCallProcess = false;
  //     });
  //   }
  // }

  void showFlutterToast(Color backgColor, Color colorTxt, Color colorIcon,
          String text, IconData iconData) =>
      fToast.showToast(
        child: customFToast(backgColor, colorTxt, colorIcon, text, iconData),
        gravity: ToastGravity.TOP,
        // positionedToastBuilder: (context, child) =>
        //     Positioned(child: child, top: 150, left: 0, right: 0),
      );

  // Widget customFToast(
  //   Color backgColor,
  //   Color colorTxt,
  //   Color colorIcon,
  //   String text,
  //   IconData iconData,
  // ) =>
  //     Container(
  //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(25),
  //         color: backgColor,
  //       ),
  //       child: Center(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(iconData, color: colorIcon),
  //             SizedBox(width: 12.0),
  //             Text(
  //               text,
  //               style: TextStyle(
  //                   fontFamily: khmerSiemreap,
  //                   package: packageKhmer,
  //                   color: colorTxt,
  //                   fontSize: 18),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
}
