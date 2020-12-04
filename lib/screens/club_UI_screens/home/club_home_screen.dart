import 'dart:convert';
import 'dart:io';

import 'package:bookario/components/constants.dart';
import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/screens/club_UI_screens/home/components/body.dart';
import 'package:bookario/screens/splash/splash_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class ClubHomeScreen extends StatefulWidget {
  static String routeName = "/clubHome";

  @override
  _ClubHomeScreenState createState() => _ClubHomeScreenState();
}

class _ClubHomeScreenState extends State<ClubHomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  File coverPhoto;
  bool loading = false;
  String _clubName, _location, _description, _coverPhotoPath, _address;
  // final List<String> errors = [];

  FocusNode clubNameFocusNode = FocusNode();
  FocusNode locationFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SplashScreen()),
        );
      }
    });
  }

  @override
  void initState() {
    this.checkAuthentification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              "assets/images/onlylogo.png",
              fit: BoxFit.cover,
            ),
          ),
          title: Text("Home"),
        ),
        body: Body(),
        floatingActionButton: FloatingActionButton(
            elevation: 10,
            child: Icon(Icons.add),
            backgroundColor: kPrimaryLightColor,
            onPressed: () => enterClubDetails(context)));
  }

  enterClubDetails(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(
                          'Add New Club',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: coverPhoto != null
                                ? Image.file(
                                    coverPhoto,
                                    width: SizeConfig.screenWidth * 0.9,
                                    height: 150,
                                    fit: BoxFit.fitHeight,
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                    ),
                                    width: SizeConfig.screenWidth * 0.75,
                                    height: 150,
                                    child:
                                        Center(child: Text('Add cover Photo')),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: clubNameFormField(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: clubLocationFormField(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: clubDescriptionFormField(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: clubAddressFormField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DefaultButton(
                            text: "Add",
                            press: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  loading = true;
                                  uploadImage();
                                  // Navigator.of(context).pop();
                                });
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: -15.0,
                  top: -15.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: kSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void uploadImage() async {
    try {
      String filename = coverPhoto.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          coverPhoto.path,
          filename: filename,
          contentType: new MediaType("image", "jpeg"),
        ),
      });
      Dio dio = new Dio();
      dio
          .post("http://bookario.com/apis/file/upload", data: formData)
          .then((response) {
        print(response);
        String imageUrl = response.data["data"]["url"];
        // print(imageUrl);
        addClub(imageUrl);
      }).catchError((e) => print(e));
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void addClub(String imageUrl) async {
    String uid = await PersistenceHandler.getter('uid');
    try {
      var response = await Networking.post('clubs/add-club', {
        'name': _clubName.trim(),
        'userId': uid,
        'location': _location.trim(),
        'description': _description.trim(),
        'coverPhoto': imageUrl,
        'address': _address.trim(),
      });
      print(response);
    } catch (e) {
      print(e);
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Select from Gallary'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _imgFromGallery() async {
    PickedFile image = await ImagePicker().getImage(
        source: ImageSource.gallery, imageQuality: 50, maxHeight: 500);
    if (image != null) {
      setState(() {
        coverPhoto = File(image.path);
        _coverPhotoPath = image.path;
      });
    }
  }

  TextFormField clubNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: clubNameFocusNode,
      onSaved: (newValue) => _clubName = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter club name";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Club Name",
        hintText: "eg: The ABC Lounge",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        clubNameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(locationFocusNode);
      },
    );
  }

  TextFormField clubLocationFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: locationFocusNode,
      onSaved: (newValue) => _location = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter club Location";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Club Location",
        hintText: "eg: Magarpatta",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        locationFocusNode.unfocus();
        FocusScope.of(context).requestFocus(descriptionFocusNode);
      },
    );
  }

  TextFormField clubDescriptionFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      focusNode: descriptionFocusNode,
      maxLines: null,
      maxLength: 500,
      onSaved: (newValue) => _description = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter club Description";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "About your club",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        descriptionFocusNode.unfocus();
        FocusScope.of(context).requestFocus(addressFocusNode);
      },
    );
  }

  TextFormField clubAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.done,
      focusNode: addressFocusNode,
      onSaved: (newValue) => _address = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter club Address";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Club Address",
        hintText: "eg: The ABC Lounge, Senapati Bapat Road, Shivajinagar, Pune",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        addressFocusNode.unfocus();
      },
    );
  }
}
