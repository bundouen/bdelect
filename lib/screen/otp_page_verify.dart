import 'dart:ui';

import 'package:bdelect/constants.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:snippet_coder_utils/ProgressHUD.dart';

class OtpVerifyPage extends StatefulWidget {
  static const routeName = '/otpverifypage';
  final String? mobileNo;
  final String? otpHash;
  OtpVerifyPage({this.mobileNo, this.otpHash});

  @override
  _OtpVerifyPageState createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  String _otpCode = "";
  final int _otpCodeLength = 4;
  bool isApiCallProcess = false;
  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
    super.initState();
    SmsAutoFill().listenForCode.call();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        key: UniqueKey(),
        opacity: 0.3,
        child: verifyOtpUI(),
      ),
    ));
  }

  verifyOtpUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/sms.png",
          height: 180,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "លេខកូដបញ្ជាក់",
            style: TextStyle(
              fontSize: 20,
              fontFamily: khmerMoul,
              package: packageKhmer,
              color: kPrimaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "សូមបញ្ជូលកូដដែលបានផ្ញើរទៅកាន់លេខទូរស័ព្ទរបស់អ្នក\n(+855)-${widget.mobileNo}",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontFamily: khmerSiemreap,
              package: packageKhmer,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: PinFieldAutoFill(
            decoration: UnderlineDecoration(
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              colorBuilder: FixedColorBuilder(
                Colors.black.withOpacity(.3),
              ),
            ),
            currentCode: _otpCode,
            codeLength: _otpCodeLength,
            onCodeChanged: (code) {
              if (code!.length == _otpCodeLength) {
                _otpCode = code;
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
          ),
        ),
        Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextButton(
                  onPressed: () {},
                  child: Container(
                    width: 150,

                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: kPrimaryColor),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                    "បញ្ជាក់",
                    style: TextStyle(
                          fontFamily: khmerMoul,
                          package: packageKhmer,
                          fontSize: 20,
                          color: kSecondaryColor,
                    ),
                  ),
                        ),
                      )))),
        )
      ],
    );
  }
}
