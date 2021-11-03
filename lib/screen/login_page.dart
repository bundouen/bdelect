import 'package:bdelect/constants.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

// import 'package:snippet_coder_utils/list_helper.dart';
// import 'package:snippet_coder_utils/multi_images_utils.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  var userName= Get.arguments??"";
  String? name;
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
            child: _loginUI(context),
            key: globalFormKey,
          ),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
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
                  'Login Page',
                  style: GoogleFonts.pacifico(
                    fontSize: 35.0,
                    color: kBColor,
                  ),
                ),
              ),
            ),
            FormHelper.inputFieldWidget(
              context,
              const Icon(Icons.person),
              "name",
              'User Name',
              (String onValidateVal) {
                if (!onValidateVal.isNotEmpty) {
                  return "Email \t is not empty";
                }
                return null;
              },
              (onSavedVal) {
                name = onSavedVal;
              },
              initialValue: userName,
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
                const Icon(Icons.person),
                "password",
                'Password',
                (String onValidateVal) {
                  if (!onValidateVal.isNotEmpty) {
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
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 5),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Forgot password ?',
                          style: const TextStyle(
                            color: kBColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: FormHelper.submitButton(
                "Login",
                () {
                  if (validateAndSave()) {}
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 5),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: kBColor,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: "Don't have acount? ",
                      ),
                      TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, "/register");
                            }),
                    ],
                  ),
                ),
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
