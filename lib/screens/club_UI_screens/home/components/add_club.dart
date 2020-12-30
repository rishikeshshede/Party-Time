import 'dart:io';

import 'package:bookario/components/constants.dart';
import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/components/size_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class AddNewClub extends StatefulWidget {
  @override
  _AddNewClubState createState() => _AddNewClubState();
}

class _AddNewClubState extends State<AddNewClub> {
  final _formKey = GlobalKey<FormState>();
  File coverPhoto;
  bool loading = false,
      hasClubs = false,
      homeLoading = true,
      loadMore = false,
      loadingMore = false,
      closeDialog = false;
  String _clubName, _location, _description, _address;
  int offset, limit;
  List<dynamic> clubData;

  FocusNode clubNameFocusNode = FocusNode();
  FocusNode locationFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Club'),
      ),
      body: Container(
        child: loading
            ? Loading()
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 10),
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
                                  child: Center(child: Text('Add cover Photo')),
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
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
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
      });
    }
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
        print(imageUrl);
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
      if (response['success']) {
        setState(() {
          loading = false;
          Navigator.of(context).pop(true);
        });
      } else
        errorWhileAddingClub(context);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> errorWhileAddingClub(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text(
            "An error occured. Please try again after sometime",
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 17,
                ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
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
