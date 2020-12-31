import 'package:bookario/components/custom_surfix_icon.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/components/constants.dart';
import 'package:bookario/components/size_config.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading;
  final List<String> errors = [];

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode ageFocusNode = FocusNode();

  final nameEditingController = TextEditingController();
  final ageEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();

  getDetails() async {
    String uid = await PersistenceHandler.getter('uid');
    var response =
        await Networking.getData('user/get-user-details', {"userId": uid});
    return response;
  }

  void initState() {
    loading = true;
    populateFields();
    super.initState();
  }

  populateFields() async {
    var res = await getDetails();
    if (res['success']) {
      // print(res['data'][0]);
      var data = res['data'][0];
      setState(() {
        nameEditingController.text = data['name'];
        ageEditingController.text = data['age'].toString();
        phoneNumberEditingController.text = data['phone'];
        loading = false;
      });
    }
  }

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

  Future<bool> _discardChanges(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text('Discard changes?',
              style: TextStyle(
                  fontSize: 17,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.bold)),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'No',
                style: TextStyle(
                    fontSize: 14,
                    letterSpacing: .8,
                    color: Theme.of(context).primaryColor),
              ),
              splashColor: Theme.of(context).primaryColorLight,
              color: Colors.black12,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                'Discard',
                style: TextStyle(
                    fontSize: 14, letterSpacing: .8, color: Colors.white),
              ),
              splashColor: Theme.of(context).primaryColorLight,
              color: Theme.of(context).primaryColor,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Edit Profile"),
      ),
      body: SafeArea(
        child: loading
            ? Loading()
            : SingleChildScrollView(
                child: Container(
                  height: SizeConfig.screenHeight * 0.8,
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      nameFormField(context),
                      SizedBox(height: 20),
                      phoneNumberFormField(context),
                      SizedBox(height: 20),
                      ageFormFIeld(),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          discardChanges(context),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: kPrimaryColor,
                            child: Text(
                              "Update",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              try {
                                String uid =
                                    await PersistenceHandler.getter('uid');
                                var response =
                                    await Networking.post('user/update-user', {
                                  'userId': uid,
                                  'name': nameEditingController.text.trim(),
                                  'phone': phoneNumberEditingController.text
                                      .trim()
                                      .toString(),
                                  'age': ageEditingController.text
                                      .trim()
                                      .toString(),
                                });
                                print(response);
                                if (response['success']) {
                                  Navigator.of(context).pop();
                                  // Navigator.of(context).pop();
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("Details Updated Successfully"),
                                  ));
                                }
                              } catch (e) {
                                print('Error updating user profile: ');
                                print(e);
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  TextFormField nameFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: nameFocusNode,
      controller: nameEditingController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Name cannot be empty");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Name cannot be empty");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Change your name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
      onFieldSubmitted: (value) {
        nameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(phoneNumberFocusNode);
      },
    );
  }

  TextFormField phoneNumberFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: phoneNumberFocusNode,
      controller: phoneNumberEditingController,
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
        hintText: "Change your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call-grey.svg"),
      ),
      onFieldSubmitted: (value) {
        phoneNumberFocusNode.unfocus();
        FocusScope.of(context).requestFocus(ageFocusNode);
      },
    );
  }

  TextFormField ageFormFIeld() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.done,
      focusNode: ageFocusNode,
      controller: ageEditingController,
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
        hintText: "Change your age",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Age.svg"),
      ),
      onFieldSubmitted: (value) {
        ageFocusNode.unfocus();
      },
    );
  }

  FlatButton discardChanges(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.black12,
      child: Text(
        "Discard",
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        _discardChanges(context);
      },
    );
  }
}
