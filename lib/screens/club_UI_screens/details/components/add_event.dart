import 'dart:convert';
import 'dart:io';

import 'package:bookario/components/constants.dart';
import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/components/size_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({
    Key key,
    @required this.club,
  }) : super(key: key);

  final club;
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();

  FocusNode eventNameFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode timeHrFocusNode = FocusNode();
  FocusNode timeMinFocusNode = FocusNode();
  FocusNode capacityFocusNode = FocusNode();
  FocusNode maleCountFocusNode = FocusNode();
  FocusNode femaleCountFocusNode = FocusNode();
  FocusNode coupleCountFocusNode = FocusNode();
  FocusNode mfmRatioFocusNode = FocusNode();
  FocusNode mffRatioFocusNode = FocusNode();
  FocusNode pricesFocusNode = FocusNode();

  File coverPhoto;
  bool loading = false;
  int _radioValue = 2;
  String _eventName,
      _description,
      _eventDate,
      _eventTimeHr,
      _eventTimeMin,
      _maleCount,
      _femaleCount,
      _coupleCount,
      _mfmRatio,
      _mffRatio,
      _capacity,
      _maleStagBasicPass = '',
      _maleCover1Pass,
      _maleCover2Pass,
      _maleCover3Pass,
      _maleCover4Pass,
      _femaleStagBasicPass = '',
      _femaleCover1Pass,
      _femaleCover2Pass,
      _femaleCover3Pass,
      _femaleCover4Pass,
      _coupleBasicPass = '',
      _coupleCover1Pass,
      _coupleCover2Pass,
      _coupleCover3Pass,
      _coupleCover4Pass,
      _availableWithCouple = 'none';
  var priceDescriptionString,
      maleStagPriceString,
      femaleStagPriceString,
      couplePriceString;

  Map<String, dynamic> priceDescription;
  Map<String, dynamic> maleStagPrices;
  Map<String, dynamic> femaleStagPrices;
  Map<String, dynamic> couplePrices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Event'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => confirmDiscard(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // overflow: Overflow.visible,
            children: <Widget>[
              loading
                  ? Loading()
                  : Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
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
                                        child: Center(
                                            child: Text('Add cover Photo')),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: eventNameFormField(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: eventDescriptionFormField(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: dateFormField(),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: timeHrFormField(),
                                  ),
                                ),
                                Text(':'),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: timeMinFormField(),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: capacityFormField(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: maleCountFormField(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: femaleCountFormField(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: coupleCountFormField(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('M/F Ratio:  '),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 3),
                                      child: mfmRatioFormField(),
                                    ),
                                  ),
                                  Text(' : '),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 3),
                                      child: mffRatioFormField(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '* Male Stag Entry Prices',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Basic Pass:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: maleStagBasicPass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 1:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: maleStagCover1Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 2:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: maleStagCover2Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 3:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: maleStagCover3Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 4:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: maleStagCover4Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '* Female Stag Entry Prices',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Basic Pass:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: femaleStagBasicPass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 1:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: femaleStagCover1Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 2:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: femaleStagCover2Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 3:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: femaleStagCover3Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 4:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: femaleStagCover4Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '* Couples Entry Prices',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Basic Pass:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: couplesBasicPass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 1:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: coupleCover1Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 2:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: coupleCover2Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 3:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: coupleCover3Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Cover Type 4:  '),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 3),
                                          child: coupleCover4Pass(),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Which entry you want to make available with each couple entry?',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: buildUserTypeRadioButtons(),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DefaultButton(
                                text: "Add",
                                press: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    if (int.parse(_maleCount) +
                                            int.parse(_femaleCount) +
                                            int.parse(_coupleCount) * 2 >
                                        int.parse(_capacity)) {
                                      showErrors(context,
                                          "Insufficient Capacity\n\nEither increase the capacity or decrease the stag or couple counts allowed for your event.");
                                    } else if (int.parse(_mfmRatio) /
                                            int.parse(_mffRatio) !=
                                        int.parse(_maleCount) /
                                            int.parse(_femaleCount)) {
                                      showErrors(context,
                                          "Male/Female count is not as per your mentioned male/female ratio.");
                                    } else if (_maleStagBasicPass == '' &&
                                        _femaleStagBasicPass == '' &&
                                        _coupleBasicPass == '') {
                                      showErrors(context,
                                          "Enter at least 1 Basic Pass price.");
                                    } else if (coverPhoto == null) {
                                      showErrors(context,
                                          "Upload an image for your event.");
                                    } else {
                                      setState(() {
                                        loading = true;
                                        uploadImage();
                                      });
                                    }
                                  } else {
                                    showErrors(context,
                                        "Error\n\nCheck event details again.");
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> showErrors(BuildContext context, String text) {
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
            text,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 17, color: Colors.white),
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
              splashColor: kSecondaryColor,
            ),
          ],
        );
      },
    );
  }

  Future<bool> confirmDiscard(BuildContext context) {
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
            "All added details will get discarded. Do you still want to go back?",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontSize: 17, color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "No",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: kSecondaryColor),
              ),
              splashColor: Colors.red[50],
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Yes",
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
        addEvent(imageUrl);
      }).catchError((e) => print(e));
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void addEvent(String imageUrl) async {
    String uid = await PersistenceHandler.getter('uid');
    setState(() {
      maleStagPrices = {
        'Basic Pass': _maleStagBasicPass == null || _maleStagBasicPass == ''
            ? 'Not Available'
            : _maleStagBasicPass,
        'Cover type 1': _maleCover1Pass == null || _maleCover1Pass == ''
            ? 'Not Available'
            : _maleCover1Pass,
        'Cover type 2': _maleCover2Pass == null || _maleCover2Pass == ''
            ? 'Not Available'
            : _maleCover2Pass,
        'Cover type 3': _maleCover3Pass == null || _maleCover3Pass == ''
            ? 'Not Available'
            : _maleCover3Pass,
        'Cover type 4': _maleCover4Pass == null || _maleCover4Pass == ''
            ? 'Not Available'
            : _maleCover4Pass,
      };
      // maleStagPriceString = maleStagPrices.toString();
      maleStagPriceString = json.encode(maleStagPrices);
      femaleStagPrices = {
        'Basic Pass': _femaleStagBasicPass == null || _femaleStagBasicPass == ''
            ? 'Not Available'
            : _femaleStagBasicPass,
        'Cover type 1': _femaleCover1Pass == null || _femaleCover1Pass == ''
            ? 'Not Available'
            : _femaleCover1Pass,
        'Cover type 2': _femaleCover2Pass == null || _femaleCover2Pass == ''
            ? 'Not Available'
            : _femaleCover2Pass,
        'Cover type 3': _femaleCover3Pass == null || _femaleCover3Pass == ''
            ? 'Not Available'
            : _femaleCover3Pass,
        'Cover type 4': _femaleCover4Pass == null || _femaleCover4Pass == ''
            ? 'Not Available'
            : _femaleCover4Pass,
      };
      // femaleStagPriceString = femaleStagPrices.toString();
      femaleStagPriceString = json.encode(femaleStagPrices);
      couplePrices = {
        'Basic Pass': _coupleBasicPass == null || _coupleBasicPass == ''
            ? 'Not Available'
            : _coupleBasicPass,
        'Cover type 1': _coupleCover1Pass == null || _coupleCover1Pass == ''
            ? 'Not Available'
            : _coupleCover1Pass,
        'Cover type 2': _coupleCover2Pass == null || _coupleCover2Pass == ''
            ? 'Not Available'
            : _coupleCover2Pass,
        'Cover type 3': _coupleCover3Pass == null || _coupleCover3Pass == ''
            ? 'Not Available'
            : _coupleCover3Pass,
        'Cover type 4': _coupleCover4Pass == null || _coupleCover4Pass == ''
            ? 'Not Available'
            : _coupleCover4Pass,
      };
      // couplePriceString = couplePrices.toString();
      couplePriceString = json.encode(couplePrices);
      priceDescription = {
        "maleStag": maleStagPriceString,
        "femaleStag": femaleStagPriceString,
        "couples": couplePriceString,
      };
      priceDescriptionString = json.encode(priceDescription);
      // print('${_eventTimeHr.trim()}:${_eventTimeMin.trim()}');
    });
    try {
      var response = await Networking.post('events/add-event', {
        'name': _eventName.trim(),
        'userId': uid,
        'clubId': widget.club['clubId'],
        'description': _description.trim(),
        'coverPhoto': imageUrl,
        'priceDescription': priceDescriptionString.toString(),
        'maleCount': int.parse(_maleCount),
        'femaleCount': int.parse(_femaleCount),
        'coupleCount': int.parse(_coupleCount),
        'mfRatio': '$_mfmRatio:$_mffRatio',
        'capacity': int.parse(_capacity),
        'isPremium': '0',
        'stagWithCouple': 1,
        'date': _eventDate.trim(),
        'time': '${_eventTimeHr.trim()}:${_eventTimeMin.trim()}',
      });
      print(response);
      if (response['success']) {
        Navigator.pop(context, true);
        showDialog(
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
                "Event added successfully.",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 17, color: Colors.white),
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
                  splashColor: kSecondaryColor,
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
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
                "An Error Occured.\nPlease try again.",
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
                  splashColor: kSecondaryColor,
                ),
              ],
            );
          },
        );
      }
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
                      title: Text('Select from Gallery'),
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

  TextFormField eventNameFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: eventNameFocusNode,
      onSaved: (newValue) => _eventName = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter event name";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Event Name",
        hintText: "eg: DJ Chetas Night",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        eventNameFocusNode.unfocus();
        FocusScope.of(context).requestFocus(descriptionFocusNode);
      },
    );
  }

  TextFormField eventDescriptionFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.text,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: descriptionFocusNode,
      maxLines: null,
      maxLength: 500,
      onSaved: (newValue) => _description = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter event description";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Description",
        hintText: "About the event",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        descriptionFocusNode.unfocus();
        FocusScope.of(context).requestFocus(dateFocusNode);
      },
    );
  }

  TextFormField dateFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.datetime,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: dateFocusNode,
      onSaved: (newValue) => _eventDate = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter event date";
        } else if (value.length != 10) {
          return "Invalid date format";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "yyyy/mm/dd",
        hintText: "2021/01/12 (Event date)",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        dateFocusNode.unfocus();
        FocusScope.of(context).requestFocus(timeHrFocusNode);
      },
    );
  }

  TextFormField timeHrFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: timeHrFocusNode,
      onSaved: (newValue) => _eventTimeHr = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter event time";
        } else if (value.length > 2) {
          return "Invalid time";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Time (24 hour format)",
        hintText: "eg: 19 (Hour)",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        timeHrFocusNode.unfocus();
        FocusScope.of(context).requestFocus(timeMinFocusNode);
      },
    );
  }

  TextFormField timeMinFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: timeMinFocusNode,
      onSaved: (newValue) => _eventTimeMin = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Cannot be empty";
        } else if (value.length > 2) {
          return "Invalid time";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "(Minutes)",
        hintText: "eg: 30",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        timeMinFocusNode.unfocus();
        FocusScope.of(context).requestFocus(capacityFocusNode);
      },
    );
  }

  TextFormField capacityFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: capacityFocusNode,
      onSaved: (newValue) => _capacity = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter capacity";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Event Capacity",
        hintText: "eg: 100",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        capacityFocusNode.unfocus();
        FocusScope.of(context).requestFocus(maleCountFocusNode);
      },
    );
  }

  TextFormField maleCountFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: maleCountFocusNode,
      onSaved: (newValue) => _maleCount = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter male count";
        } else if (_availableWithCouple == 'femaleStag') {
          return "Must be 0";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Male Count",
        hintText: "eg: 40",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        maleCountFocusNode.unfocus();
        FocusScope.of(context).requestFocus(femaleCountFocusNode);
      },
    );
  }

  TextFormField femaleCountFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: femaleCountFocusNode,
      onSaved: (newValue) => _femaleCount = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter female count";
        } else if (_availableWithCouple == 'maleStag') {
          return "Must be 0";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Female Count",
        hintText: "eg: 30",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        femaleCountFocusNode.unfocus();
        FocusScope.of(context).requestFocus(coupleCountFocusNode);
      },
    );
  }

  TextFormField coupleCountFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: coupleCountFocusNode,
      onSaved: (newValue) => _coupleCount = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter couple count";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Couple Count",
        hintText: "eg: 30",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        coupleCountFocusNode.unfocus();
        FocusScope.of(context).requestFocus(mfmRatioFocusNode);
      },
    );
  }

  TextFormField mfmRatioFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: mfmRatioFocusNode,
      onSaved: (newValue) => _mfmRatio = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter male ratio";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Male",
        hintText: "eg: 1",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        mfmRatioFocusNode.unfocus();
        FocusScope.of(context).requestFocus(mffRatioFocusNode);
      },
    );
  }

  TextFormField mffRatioFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.go,
      focusNode: mffRatioFocusNode,
      onSaved: (newValue) => _mffRatio = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return "Enter female ratio";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Female",
        hintText: "eg: 2",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        mffRatioFocusNode.unfocus();
        FocusScope.of(context).requestFocus(pricesFocusNode);
      },
    );
  }

  TextFormField maleStagBasicPass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      focusNode: pricesFocusNode,
      onSaved: (newValue) => _maleStagBasicPass = newValue,
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 749",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        pricesFocusNode.unfocus();
      },
    );
  }

  TextFormField maleStagCover1Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _maleCover1Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 849",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField maleStagCover2Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _maleCover2Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 949",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField maleStagCover3Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _maleCover3Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 999",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField maleStagCover4Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _maleCover4Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 1299",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField femaleStagBasicPass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _femaleStagBasicPass = newValue,
      validator: (value) {
        // if (value.isEmpty &&
        //     _maleStagBasicPass == null &&
        //     _coupleBasicPass == null) {
        //   return "Enter at least one basic pass price";
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 749",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField femaleStagCover1Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _femaleCover1Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 849",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField femaleStagCover2Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _femaleCover2Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 949",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField femaleStagCover3Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _femaleCover3Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 999",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField femaleStagCover4Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _femaleCover4Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 1299",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField couplesBasicPass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _coupleBasicPass = newValue,
      validator: (value) {
        // if (value.isEmpty &&
        //     _femaleStagBasicPass == null &&
        //     _maleStagBasicPass == null) {
        //   return "Enter at least one basic pass price";
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 749",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField coupleCover1Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _coupleCover1Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 849",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField coupleCover2Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _coupleCover2Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 949",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField coupleCover3Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _coupleCover3Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 999",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  TextFormField coupleCover4Pass() {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      keyboardType: TextInputType.number,
      cursorColor: Colors.white70,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) => _coupleCover4Pass = newValue,
      validator: (value) {
        if (value.isEmpty) {
          // return "Enter Price";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "In Rs.",
        hintText: "eg: 1299",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onFieldSubmitted: (value) {
        // maleStagFocusNode.unfocus();
      },
    );
  }

  Row buildUserTypeRadioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: [
            Radio(
              activeColor: kPrimaryColor,
              value: 0,
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            Text(
              "Male Stag",
            ),
          ],
        ),
        Column(
          children: [
            Radio(
              activeColor: kPrimaryColor,
              value: 1,
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            Text(
              "Female Stag",
            ),
          ],
        ),
        Column(
          children: [
            Radio(
              activeColor: kPrimaryColor,
              value: 2,
              groupValue: _radioValue,
              onChanged: _handleRadioValueChange,
            ),
            Text(
              "None",
            ),
          ],
        ),
      ],
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _availableWithCouple = 'maleStag';
          break;
        case 1:
          _availableWithCouple = 'femaleStag';
          break;
        case 2:
          _availableWithCouple = 'none';
          break;
      }
    });
  }
}
