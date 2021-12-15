import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;
  String? password;
  //it will maintian the state of the form whenever the state of the form changes through setState().
  // It will basically keep track of the changes of state of the form
  //it also uniquely identifies the form, and allows validation of the form in a later step
  String? email;

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      //Creates a box in which a single widget can be scrolled.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/ShoppingAppLogo.png",
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 50, bottom: 30),
            child: Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
          //email form field
          FormHelper.inputFieldWidget(
            context,
            Icon(Icons.person),
            "email",
            "Email",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Email can't be empty";
              }
              if (EmailValidator.validate(onValidateVal)) {
                  return "Please enter a valid email";
                }
              return null;
            },
            (onSavedVal) => {email = onSavedVal},
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10,
          ),
          //password form field
          // SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: FormHelper.inputFieldWidget(
                context, Icon(Icons.person), "password", "Password",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Password can't be empty";
              }
              return null;
            }, (onSavedVal) => {password = onSavedVal},
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10,
                obscureText: hidePassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Colors.white,
                    icon: Icon(hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 25),
            child: Align(
              alignment: Alignment.bottomRight,
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      children: [
                    TextSpan(
                        text: "Forget Password ?",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                        //On clicking the hyper link, this function below would be called
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Forget pasword');
                          })
                  ])), // hyperlink
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: FormHelper.submitButton("Login", () {},
                btnColor: HexColor("#283B71"),
                borderColor: Colors.white,
                txtColor: Colors.white,
                borderRadius: 10),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "OR",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      children: [
                    TextSpan(text: "Don't have an account ?"),
                    TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                        //On clicking the hyper link, this function below would be called
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/register');
                          })
                  ])), // hyperlink
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: HexColor('#283B71'),
          body: ProgressHUD(
            child: Form(
              key: globalFormKey,
              child: _loginUI(context),
            ),
            inAsyncCall: isApiCallProcess,
            opacity: 0.3,
            key: UniqueKey(),
          )),
    );
  }
}
