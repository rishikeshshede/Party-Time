import 'package:bookario/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookario/components/custom_surfix_icon.dart';
import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/form_error.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:bookario/screens/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String customerName, email, phoneNumber, gender, password, confirmPassword;
  int age;
  bool remember = false, _obscureText = true;
  final List<String> errors = [];

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(16)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(16)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(16)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(16)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(16)),
          Row(
            children: [
              buildAgeFormField(),
              SizedBox(width: getProportionateScreenHeight(10)),
              buildGenderFormField()
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Register",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      cursorColor: Colors.black,
      onSaved: (newValue) => customerName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Enter your name");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Please Enter your name");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      onSaved: (newValue) => email = newValue,
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
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please Enter your Phone Number");
        } else if (value.length == 10) {
          removeError(error: "Please Enter valid Phone Number");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Please Enter your Phone Number");
          return "";
        } else if (value.length != 10) {
          addError(error: "Please Enter valid Phone Number");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your Phone Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _obscureText,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
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
                    FontAwesomeIcons.eye,
                    size: 17,
                  ),
                )
              : GestureDetector(
                  onTap: () => _toggle(),
                  child: FaIcon(
                    FontAwesomeIcons.eyeSlash,
                    size: 17,
                  ),
                ),
        ),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: _obscureText,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(error: kMatchPassError);
        }
        confirmPassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: _obscureText
              ? GestureDetector(
                  onTap: () => _toggle(),
                  child: FaIcon(
                    FontAwesomeIcons.eye,
                    size: 17,
                  ),
                )
              : GestureDetector(
                  onTap: () => _toggle(),
                  child: FaIcon(
                    FontAwesomeIcons.eyeSlash,
                    size: 17,
                  ),
                ),
        ),
      ),
    );
  }

  Expanded buildGenderFormField() {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: gender,
        isExpanded: false,
        onChanged: (String value) {
          setState(() {
            gender = value;
          });
        },
        items: ['Male', 'Female', 'Others']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
        validator: (value) => value == null ? 'Select Gender' : null,
        decoration: InputDecoration(
          labelText: 'Gender',
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }

  Expanded buildAgeFormField() {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.name,
        onSaved: (newValue) => customerName = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: "Please Enter your age");
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: "Please Enter your age");
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Age",
          hintText: "Enter your Age",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Plus Icon.svg"),
        ),
      ),
    );
  }
}
