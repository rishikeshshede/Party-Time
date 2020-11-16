import 'package:bookario/components/bottom_navbar.dart';
import 'package:bookario/components/dialogueBox.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/screens/club_UI_screens/home/club_home_screen.dart';
import 'package:bookario/screens/sign_up/components/bottom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookario/components/custom_surfix_icon.dart';
import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/form_error.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _customerName,
      _email,
      _phoneNumber,
      _gender,
      _password,
      _confirmPassword,
      _userType = 'Customer',
      _age;
  int _radioValue = 0;
  bool _obscureText = true, loading = false;
  final List<String> errors = [];

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();

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
    return Form(
      key: _formKey,
      child: loading
          ? Loading()
          : Column(
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
                SizedBox(height: getProportionateScreenHeight(16)),
                buildUserTypeRadioButtons(),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButton(
                  text: "Register",
                  press: () async {
                    if (validateAndSave()) {
                      setState(() {
                        loading = true;
                        signUp();
                      });
                    }
                  },
                ),
                SignupScreenBottomText()
              ],
            ),
    );
  }

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        final databaseReference = FirebaseFirestore.instance;
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: _email.trim(), password: _password.trim());
        User user = userCredential.user;
        user.sendEmailVerification().then((onValue) {
          print("Verification mail sent on ${user.email}");
        });
        if (user != null) {
          user.updateProfile(displayName: _customerName.trim());
          if (_userType == 'Customer') {
            try {
              DocumentReference ref =
                  await databaseReference.collection("customers").add({
                'name': _customerName.trim(),
                'email': _email.trim(),
                'phoneNumber': _phoneNumber.trim(),
                'age': _age.trim(),
                'gender': _gender,
                'userType': _userType,
              });
              print('User data of ${ref.id} customer updated to firestore');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomCustomNavBar(),
                  ),
                  (Route<dynamic> route) => false);
            } catch (e) {
              print(e.toString());
            }
          } else {
            try {
              DocumentReference ref =
                  await databaseReference.collection("clubs").add({
                'name': _customerName.trim(),
                'email': _email.trim(),
                'phoneNumber': _phoneNumber.trim(),
                'age': _age.trim(),
                'gender': _gender,
                'userType': _userType,
              });
              print('User data of ${ref.id} club updated to firestore');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClubHomeScreen(),
                  ),
                  (Route<dynamic> route) => false);
            } catch (e) {
              print(e.toString());
            }
          }
          PersistenceHandler.setter("uid", user.uid);
          PersistenceHandler.setter("userType", _userType);
        }
      } catch (e) {
        loading = false;
        ShowAlert.showAlert(context, e.errormessage);
      }
    }
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: nameFocusNode,
      onSaved: (newValue) => _customerName = newValue,
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
      onFieldSubmitted: (value) {
        nameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(emailFocusNode);
      },
    );
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
        FocusScope.of(context).requestFocus(phoneNumberFocusNode);
      },
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: phoneNumberFocusNode,
      onSaved: (newValue) => _phoneNumber = newValue,
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
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call-grey.svg"),
      ),
      onFieldSubmitted: (value) {
        phoneNumberFocusNode.unfocus();
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _obscureText,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: passwordFocusNode,
      onSaved: (newValue) => _password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        _password = value;
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
      ),
      onFieldSubmitted: (value) {
        passwordFocusNode.unfocus();
        FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
      },
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: _obscureText,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: confirmPasswordFocusNode,
      onSaved: (newValue) => _confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && _password == _confirmPassword) {
          removeError(error: kMatchPassError);
        }
        _confirmPassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((_password != value)) {
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
        confirmPasswordFocusNode.unfocus();
        FocusScope.of(context).requestFocus(ageFocusNode);
      },
    );
  }

  Expanded buildAgeFormField() {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.done,
        focusNode: ageFocusNode,
        onSaved: (newValue) => _age = newValue,
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
          prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Age.svg"),
        ),
        onFieldSubmitted: (value) {
          ageFocusNode.unfocus();
          FocusScope.of(context).requestFocus(genderFocusNode);
        },
      ),
    );
  }

  Expanded buildGenderFormField() {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: _gender,
        isExpanded: false,
        onChanged: (String value) {
          setState(() {
            _gender = value;
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

  Row buildUserTypeRadioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          activeColor: kPrimaryColor,
          value: 0,
          groupValue: _radioValue,
          onChanged: _handleRadioValueChange,
        ),
        Text(
          "Customer",
        ),
        Radio(
          activeColor: kPrimaryColor,
          value: 1,
          groupValue: _radioValue,
          onChanged: _handleRadioValueChange,
        ),
        Text(
          "Club",
        ),
      ],
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _userType = 'Customer';
          break;
        case 1:
          _userType = 'Club';
          break;
      }
    });
  }
}
