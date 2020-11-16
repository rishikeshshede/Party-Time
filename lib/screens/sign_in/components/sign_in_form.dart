import 'package:bookario/components/bottom_navbar.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/dialogueBox.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/screens/club_UI_screens/home/club_home_screen.dart';
import 'package:bookario/screens/sign_in/components/bottom_text.dart';
import 'package:bookario/screens/sign_in/components/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookario/components/custom_surfix_icon.dart';
import 'package:bookario/components/form_error.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _obscureText = true, loading = false;
  final List<String> errors = [];

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Form(
            key: _formKey,
            child: Column(
              children: [
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(25)),
                ForgotPassword(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  text: "Sign In",
                  press: () async {
                    if (validateAndSave()) {
                      setState(() {
                        loading = true;
                      });
                      login();
                    }
                  },
                ),
                SigninScreenBottomText()
              ],
            ),
          );
  }

  void login() async {
    String userType;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email.trim(), password: _password.trim());
      User user = userCredential.user;
      if (user != null) {
        userType = await PersistenceHandler.getter("userType");
        if (userType == 'Customer') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomCustomNavBar(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ClubHomeScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        setState(() {
          loading = false;
        });
        ShowAlert.showAlert(context, "User does not exist.");
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      print(e.message);
      ShowAlert.showAlert(context, "Invalid Credentials.\nTry again.");
    }
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: emailFocusNode,
      onSaved: (newValue) => _email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
      onFieldSubmitted: (value) {
        emailFocusNode.unfocus();
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _obscureText,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.done,
      focusNode: passwordFocusNode,
      onSaved: (newValue) => _password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: _obscureText
              ? GestureDetector(
                  onTap: () => _toggle(),
                  child: FaIcon(
                    FontAwesomeIcons.eyeSlash,
                    size: 17,
                  ),
                )
              : GestureDetector(
                  onTap: () => _toggle(),
                  child: FaIcon(
                    FontAwesomeIcons.eye,
                    size: 17,
                  ),
                ),
        ),
      ),
      onFieldSubmitted: (value) {
        passwordFocusNode.unfocus();
      },
    );
  }
}
