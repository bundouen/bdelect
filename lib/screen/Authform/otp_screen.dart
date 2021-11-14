import 'package:bdelect/constants.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _pinOTPCodeController = TextEditingController();

  final FocusNode _pinCodeFocus = FocusNode();

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: widget.phone,
        timeOutDuration: const Duration(seconds: 60),
        onLoginSuccess: (userCredential, autoVerified) async {
          print(autoVerified
              ? "OTP was fetched automatically"
              : "OTP was verified manually");

          print("Login Success BBBBB UID: ${userCredential.user?.uid}");
        },
        onLoginFailed: (authException) {
          print("An error occurred: ${authException.message}");

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
                                    child: Text(
                                      controller.timerIsActive
                                          ? "${controller.timerCount.inSeconds + 1}s"
                                          : "ផ្ញើរម្តទៀត",
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
                                        print(
                                          "Please enter the correct OTP sent to ${widget.phone}",
                                        );
                                      } else {
                                        print(
                                          "AAAAAAAAAAAAA Successfuly",
                                        );
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
                  : Column(
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
                    ),
            ),
          );
        },
      ),
    );
  }
}
