import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/components/constants.dart';
import 'package:bookario/components/size_config.dart';
import 'package:bookario/screens/club_UI_screens/home/club_home_screen.dart';
import 'package:flutter/material.dart';

class EditClubDetails extends StatefulWidget {
  final clubId;

  const EditClubDetails({Key key, this.clubId}) : super(key: key);
  @override
  _EditClubDetailsState createState() => _EditClubDetailsState();
}

class _EditClubDetailsState extends State<EditClubDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading;
  final List<String> errors = [];
  String photoUrl;

  FocusNode nameFocusNode = FocusNode();
  FocusNode locationFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  final nameEditingController = TextEditingController();
  final locaitonEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

  getDetails() async {
    var response = await Networking.getData(
        'clubs/get-club-details', {"clubId": widget.clubId.toString()});
    return response;
  }

  void initState() {
    loading = true;
    populateFields();
    super.initState();
  }

  populateFields() async {
    var response = await getDetails();
    if (response['success']) {
      var data = response['data'][0];
      setState(() {
        nameEditingController.text = data['name'];
        locaitonEditingController.text = data['location'].toString();
        addressEditingController.text = data['address'];
        descriptionEditingController.text = data['description'];
        photoUrl = data['image'];
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
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text('Discard changes?',
              style: TextStyle(
                  fontSize: 17,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
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
        title: Text("Edit Club Details"),
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
                      locationFormField(context),
                      SizedBox(height: 20),
                      addressFormFIeld(),
                      SizedBox(height: 20),
                      descriptionFormFIeld(),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          discardChanges(context),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: kSecondaryColor,
                            child: Text(
                              "Update",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              try {
                                var response =
                                    await Networking.post('clubs/update-club', {
                                  'clubId': widget.clubId.toString(),
                                  'name': nameEditingController.text.trim(),
                                  'location':
                                      locaitonEditingController.text.trim(),
                                  'address': addressEditingController.text
                                      .trim()
                                      .toString(),
                                  'description': descriptionEditingController
                                      .text
                                      .trim()
                                      .toString(),
                                  'coverPhoto': photoUrl,
                                });
                                print(response);
                                if (response['success']) {
                                  // Navigator.of(context).pop();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClubHomeScreen(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("Details Updated Successfully"),
                                  ));
                                } else {
                                  errorInUpdating(context);
                                }
                              } catch (e) {
                                print('Error updating club details: ');
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
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      cursorColor: Colors.white70,
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
        hintText: "Change club name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        nameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(locationFocusNode);
      },
    );
  }

  TextFormField locationFormField(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.text,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: locationFocusNode,
      controller: locaitonEditingController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please enter club location");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Please enter club location");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Club Location",
        hintText: "Change your club's location",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        locationFocusNode.unfocus();
        FocusScope.of(context).requestFocus(addressFocusNode);
      },
    );
  }

  TextFormField addressFormFIeld() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.text,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: addressFocusNode,
      controller: addressEditingController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please enter club address");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Please enter club address");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Change your club's address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        addressFocusNode.unfocus();
        FocusScope.of(context).requestFocus(descriptionFocusNode);
      },
    );
  }

  TextFormField descriptionFormFIeld() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.text,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      focusNode: descriptionFocusNode,
      controller: descriptionEditingController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Please enter club description");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Please enter club description");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "Change your club's description",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        descriptionFocusNode.unfocus();
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
          color: Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        _discardChanges(context);
      },
    );
  }

  Future<bool> errorInUpdating(BuildContext context) {
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
            "An error occured, please try again after sometime.",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 17, color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
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
}
