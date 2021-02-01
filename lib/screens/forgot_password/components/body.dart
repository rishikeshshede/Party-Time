import 'package:bookario/components/dialogueBox.dart';
import 'package:bookario/screens/sign_in/sign_in_screen.dart';
import 'package:bookario/screens/sign_up/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookario/components/custom_surfix_icon.dart';
import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/form_error.dart';
import 'package:bookario/components/change_onboarding_screen.dart';
import 'package:bookario/components/size_config.dart';

import '../../../components/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Please enter your email and we will send you a link on your email to reset your password.",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String _email;
  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  void forgotPassword() async {
    setState(() {
      loading = true;
    });
    try {
      print(_email.trim());
      await _auth.sendPasswordResetEmail(email: _email.trim());
      setState(() {
        loading = false;
      });
      resetEmailSent(context);
    } catch (e) {
      setState(() {
        loading = false;
      });
      ShowAlert.showAlert(context, "Invalid Email");
    }
  }

  bool validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<bool> resetEmailSent(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text(
            "An email to reset your password is sent to your email ID.",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 17, color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                "Ok",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kSecondaryColor),
              ),
              splashColor: Colors.red[50],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => _email = newValue,
            cursorColor: Colors.white70,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "Reset",
            press: () async {
              if (validateAndSave()) {
                forgotPassword();
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          ChangeOnboardingScreenText(
            textFirst: "Don't have an account? ",
            clickableText: "Sign Up",
            onPressed: () {
              Navigator.pushNamed(context, SignUpScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
