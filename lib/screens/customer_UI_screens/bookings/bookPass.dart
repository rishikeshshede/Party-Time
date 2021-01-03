import 'package:bookario/components/constants.dart';
import 'package:bookario/screens/customer_UI_screens/bookings/bookingList.dart';
import 'package:bookario/screens/customer_UI_screens/details/components/all_prices.dart';
import 'package:flutter/material.dart';

class BookPass extends StatefulWidget {
  final event;
  const BookPass({Key key, @required this.event}) : super(key: key);

  @override
  _BookPassState createState() => _BookPassState();
}

class _BookPassState extends State<BookPass> {
  GlobalKey<FormState> _bookingFormKey = GlobalKey<FormState>();
  bool booked = true; // TODO: change to false
  bool addClicked = false;
  final List<Map> bookings = [];
  final List<String> errors = [];
  String bookingByName,
      name1,
      age1,
      _gender1 = "Male",
      name2,
      age2,
      _gender2 = "Male",
      stagName,
      stagAge,
      _stagGender = "Male";

  void addBooking(String name, String age, String gender) {
    setState(() {
      bookings.add({'name': name, 'age': age, 'gender': gender});
    });
  }

  bool validateAndSave() {
    final FormState form = _bookingFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Book'),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      widget.event['name'],
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 15),
                    child: AllPrices(
                        priceDescription: widget.event['priceDescription']),
                  ),
                  addClicked
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                              key: _bookingFormKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text('Add new',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  bookByNameFormField(),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      age1FormField(),
                                      SizedBox(width: 5),
                                      gender1FormField()
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FlatButton(
                                        onPressed: () {
                                          if (validateAndSave()) {
                                            addBooking(
                                              bookingByName,
                                              age1,
                                              _gender1,
                                            );
                                            setState(() {
                                              addClicked = false;
                                            });
                                          }
                                        },
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        color: kPrimaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        )
                      : Container(),
                  booked
                      ? Column(children: [
                          // Text(bookings[0]['name']),
                          BookingList(bookingList: bookings)
                        ])
                      : Text('No tickets booked yet'),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 2.5),
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            addClicked = true;
                          });
                        },
                        child: Text(
                          'Book',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 2.5, right: 5),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Proceed to pay',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField bookByNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      onSaved: (newValue) => bookingByName = newValue,
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
        labelText: "Booking by name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField name1FormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      onSaved: (newValue) => name1 = newValue,
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Expanded age1FormField() {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.go,
        onSaved: (newValue) => age1 = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: "Please Enter age");
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: "Please Enter age");
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Age",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  Expanded gender1FormField() {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: _gender1,
        isExpanded: false,
        onChanged: (String value) {
          setState(() {
            _gender1 = value;
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

  TextFormField name2FormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      onSaved: (newValue) => name2 = newValue,
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Expanded age2FormField() {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.go,
        onSaved: (newValue) => age2 = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: "Please Enter age");
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: "Please Enter age");
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Age",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  Expanded gender2FormField() {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: _gender2,
        isExpanded: false,
        onChanged: (String value) {
          setState(() {
            _gender2 = value;
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

  TextFormField stagNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      cursorColor: Colors.black,
      textInputAction: TextInputAction.go,
      onSaved: (newValue) => stagName = newValue,
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Expanded stagAgeFormField() {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.go,
        onSaved: (newValue) => stagAge = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: "Please Enter age");
          }
          return null;
        },
        validator: (value) {
          if (value.isEmpty) {
            addError(error: "Please Enter age");
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Age",
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  Expanded stagGenderFormField() {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: _stagGender,
        isExpanded: false,
        onChanged: (String value) {
          setState(() {
            _stagGender = value;
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
}
