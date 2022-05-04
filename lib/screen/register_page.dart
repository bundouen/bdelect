import 'package:bdelect/constants.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

// import 'package:snippet_coder_utils/list_helper.dart';
// import 'package:snippet_coder_utils/multi_images_utils.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/register";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? userName;
  String? phone;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          key: UniqueKey(),
          opacity: 0.3,
          child: Form(
            child: _registerUI(context),
            key: globalFormKey,
          ),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: SizedBox(
                height: 180,
                child: Image.asset(
                  "assets/images/bdlogo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  bottom: 20,
                ),
                child: Text(
                  'Registeration',
                  style: GoogleFonts.pacifico(
                    fontSize: 35.0,
                    color: kBColor,
                  ),
                ),
              ),
            ),
            FormHelper.inputFieldWidget(
              context,
              const Icon(Icons.person).toString(),
              "username",
              (String onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "User Name \t is not empty";
                }
                return null;
              },
              (onSavedVal) {
                userName = onSavedVal;
              },
              borderColor: Colors.blueAccent,
              prefixIconColor: Colors.blueAccent,
              textColor: Colors.black,
              hintColor: Colors.grey[500]!,
              borderFocusColor: kPrimaryColor,
              // borderRadius: 30
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.phone).toString(),
                "phone",
    
                (String onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "Phone \t is not empty";
                  }

                  return null;
                },
                (onSavedVal) {
                  phone = onSavedVal;
                },
                borderColor: Colors.blueAccent,
                prefixIconColor: Colors.blueAccent,
                textColor: Colors.black,
                hintColor: Colors.grey[500]!,
                borderFocusColor: kPrimaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FormHelper.inputFieldWidget(
                context,
                const Icon(Icons.password).toString(),
                "password",
                
                (String onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "Password \t is not empty";
                  }
                  return null;
                },
                (onSavedVal) {
                  password = onSavedVal;
                },
                borderColor: Colors.blueAccent,
                prefixIconColor: Colors.blueAccent,
                textColor: Colors.black,
                hintColor: Colors.grey[500]!,
                borderFocusColor: kPrimaryColor,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Colors.blueAccent,
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FormHelper.submitButton(
                "Sign Up",
                () async {
                  if (validateAndSave()) {
                    setState(() {
                      isApiCallProcess = true;
                    });
                    // bool _registered = await _userController.fetchRegister(
                    //   userName!,
                    //   phone!,
                    //   password!,
                    // );
                    // if (_registered == true) {
                    //   setState(() {
                    //     isApiCallProcess = false;
                    //   });

                    //   Get.offNamed(LoginPage.routeName, arguments: userName);
                    // }

                    // FormHelper.showSimpleAlertDialog(
                    //   context,
                    //   "Registered",
                    //   "Registered Successfully! Please login",
                    //   "Ok",
                    //   () {
                    //     // Navigator.pushNamedAndRemoveUntil(
                    //     //   context,
                    //     //   "/login",
                    //     //   (route) => false,
                    //     // );
                    //     Get.offNamed(LoginPage.routeName);
                    //   },
                    // );

                  }
                },
                // btnColor: kBColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
