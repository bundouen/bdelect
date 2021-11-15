import 'package:bdelect/constants.dart';
import 'package:bdelect/controller/user_controller.dart';
import 'package:bdelect/screen/Authform/login_screen.dart';
import 'package:bdelect/widget/custom_toast.dart';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:pinput/pin_put/pin_put.dart';

// ignore: must_be_immutable
class OTPScreen extends StatefulWidget {
  final String phone;
  final String userName;
  final String password;
  OTPScreen({
    required this.phone,
    required this.userName,
    required this.password,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? _enteredOTP;
  bool duration = false;
  bool sentFail = false;
  String btResent = "ផ្ញើរម្តទៀត";
  final fToast = FToast();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _pinOTPCodeController = TextEditingController();

  final UserController _userController = Get.find<UserController>();

  final FocusNode _pinCodeFocus = FocusNode();

  @override
  void initState() {
    fToast.init(context);
    super.initState();
  }

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey),
  );

  registerToDB() async {
    await _userController
        .fetchRegister(widget.userName, widget.phone, widget.password)
        .then((value) {
      if (value == 'true') {
        showFlutterToast(Colors.indigo, kSecondaryColor, kSecondaryColor,
            _userController.msgRegistered, Icons.check);
        Get.offNamed(LoginScreen.routeName);
      }
    });
  }

  void showFlutterToast(Color backgColor, Color colorTxt, Color colorIcon,
          String text, IconData iconData) =>
      fToast.showToast(
        child: customFToast(backgColor, colorTxt, colorIcon, text, iconData),
        gravity: ToastGravity.TOP,
        // positionedToastBuilder: (context, child) =>
        //     Positioned(child: child, top: 150, left: 0, right: 0),
      );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: widget.phone,
        timeOutDuration: Duration(seconds: 100),
        onLoginSuccess: (userCredential, autoVerified) async {
          setState(() {
            sentFail = false;
          });
          // print(autoVerified
          //     ? "OTP was fetched automatically"
          //     : "OTP was verified manually");

          // print("Login Success BBBBB UID: ${userCredential.user?.uid}");
        },
        onLoginFailed: (authException) {
          setState(() {
            sentFail = true;
          });
          // print("An error occurred: ${authException.message}");

          // handle error further if needed
        },
        builder: (context, controller) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: kSecondaryColor,
              body: controller.codeSent
                  ? Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  color: kPrimaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: duration == false
                                        ? Text(
                                            controller.timerIsActive
                                                ? "${controller.timerCount.inSeconds}s"
                                                : btResent,
                                            style: TextStyle(
                                              color: kSecondaryColor,
                                              fontSize: 18,
                                              fontFamily: khmerSiemreap,
                                              package: packageKhmer,
                                            ),
                                          )
                                        : Text(
                                            "ជោគជ័យ",
                                            style: TextStyle(
                                              color: kSecondaryColor,
                                              fontSize: 18,
                                              fontFamily: khmerSiemreap,
                                              package: packageKhmer,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              onPressed: controller.timerIsActive
                                  ? null
                                  : () async {
                                      await controller.sendOTP();
                                    },
                            ),
                            SizedBox(width: 5),
                            Text(
                              "លេខកូដបានផ្ញើរទៅលេខ ${widget.phone}",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: khmerSiemreap,
                                package: packageKhmer,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "បញ្ជូលកូដ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: khmerSiemreap,
                                package: packageKhmer,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: PinPut(
                                fieldsCount: 6,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                                eachFieldWidth: 40,
                                eachFieldHeight: 55,
                                autofocus: true,
                                focusNode: _pinCodeFocus,
                                controller: _pinOTPCodeController,
                                submittedFieldDecoration: pinOTPCodeDecoration,
                                selectedFieldDecoration: pinOTPCodeDecoration,
                                followingFieldDecoration: pinOTPCodeDecoration,
                                pinAnimationType: PinAnimationType.scale,
                                onSubmit: (pin) async {
                                  try {
                                    _enteredOTP = pin;
                                    if (this._enteredOTP?.length == 6) {
                                      final res = await controller.verifyOTP(
                                          otp: _enteredOTP!);
                                      // Incorrect OTP
                                      if (!res) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: kRColor,
                                            content: Text(
                                              "សូមបញ្ជូលលេខកូដត្រឹមត្រូវ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: khmerSiemreap,
                                                  package: packageKhmer,
                                                  color: kSecondaryColor),
                                            ),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          duration = true;
                                        });
                                        registerToDB();
                                      }
                                    }
                                  } catch (e) {
                                    FocusScope.of(context).unfocus();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Invalid OTP"),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : sentFail == false
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 50),
                            Center(
                              child: Text(
                                "កំពុងផ្ញើរកូដ...",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: khmerSiemreap,
                                    package: packageKhmer,
                                    color: kPrimaryColor),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "សូមប្តូរលេខទូរស័ព្ទហើយព្យាយាមម្តងទៀត!",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: khmerSiemreap,
                                    package: packageKhmer,
                                    color: kRColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(Icons.arrow_back_sharp),
                              ),
                            ),
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }
}
