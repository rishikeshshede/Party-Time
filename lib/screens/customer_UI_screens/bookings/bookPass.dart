import 'dart:convert';

import 'package:bookario/components/constants.dart';
import 'package:bookario/screens/customer_UI_screens/bookings/makePayment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookPass extends StatefulWidget {
  final event;
  const BookPass({Key key, @required this.event}) : super(key: key);

  @override
  _BookPassState createState() => _BookPassState();
}

class _BookPassState extends State<BookPass> {
  GlobalKey<FormState> _bookingFormKey = GlobalKey<FormState>();
  bool booked = false;
  bool addClicked = false, isPassCoupleType = false;
  final List<Map> bookings = [];
  final List<String> errors = [];
  static Map prices, maleStag, femaleStag, couples;
  String bookingByName,
      gender,
      name1,
      age1,
      _gender1 = "Male",
      name2,
      age2,
      _gender2 = "Female",
      stagName,
      stagAge,
      _stagGender = "Male",
      price1,
      price2,
      price3,
      passtype,
      passCat = "Male Stag";

  int totalPrice = 0;

  void addStagBooking(String name) {
    // print(name1);
    setState(() {
      bookings.add({
        'passCategory': passCat,
        'passType': passtype,
        'price': price1,
        'name': name,
        'age': age1,
        'gender': gender,
      });
    });
  }

  void addCouplesBooking(String name) {
    setState(() {
      bookings.add({
        'passCategory': "Couples",
        'passType': passtype,
        'price': price1,
        'maleName': name,
        'maleAge': age1,
        'maleGender': _gender1,
        'femaleName': name2,
        'femaleAge': age2,
        'femaleGender': _gender2,
      });
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
  void initState() {
    prices = json.decode(widget.event['priceDescription']);
    maleStag = json.decode(prices['maleStag']);
    femaleStag = json.decode(prices['femaleStag']);
    couples = json.decode(prices['couples']);
    super.initState();
  }

  Future<bool> confirmDiscard(BuildContext context) {
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
            "All added passes will get discarded. Do you will want to go back?",
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 17,
                ),
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
                Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Book'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => confirmDiscard(context),
          ),
        ),
        body: Builder(
          builder: (context) => Stack(
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
                        //   child: AllPricesWithBooking(
                        //       priceDescription: widget.event['priceDescription']),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/Cash.svg",
                                        height: 12,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Couple Pass",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: couples.entries
                                      .map<Widget>(
                                        (e) => e.value.toString() ==
                                                "Not Available"
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        e.key + " : ",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Text(
                                                        "₹ " +
                                                            e.value.toString(),
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          isPassCoupleType =
                                                              true;
                                                          passtype =
                                                              e.key.toString();
                                                          price1 = e.value
                                                              .toString();
                                                          addClicked = true;
                                                        });
                                                      })
                                                ],
                                              ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/Cash.svg",
                                        height: 12,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Male Stag Pass",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: maleStag.entries
                                      .map<Widget>(
                                        (e) => e.value.toString() ==
                                                "Not Available"
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        e.key + " : ",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Text(
                                                        "₹ " +
                                                            e.value.toString(),
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          isPassCoupleType =
                                                              false;
                                                          passCat = "Male Stag";
                                                          passtype =
                                                              e.key.toString();
                                                          price1 = e.value
                                                              .toString();
                                                          gender = "Male";
                                                          // print(price1);
                                                          // print(gender);
                                                          addClicked = true;
                                                        });
                                                      })
                                                ],
                                              ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/Cash.svg",
                                        height: 12,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Female Stag Pass",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: femaleStag.entries
                                      .map<Widget>(
                                        (e) => e.value.toString() ==
                                                "Not Available"
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        e.key + " : ",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      Text(
                                                        "₹ " +
                                                            e.value.toString(),
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          isPassCoupleType =
                                                              false;
                                                          passCat =
                                                              "Female Stag";
                                                          passtype =
                                                              e.key.toString();
                                                          price1 = e.value
                                                              .toString();
                                                          gender = "Female";
                                                          // print(price1);
                                                          // print(gender);
                                                          addClicked = true;
                                                        });
                                                      })
                                                ],
                                              ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ],
                        )),
                    addClicked
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                                key: _bookingFormKey,
                                child: isPassCoupleType
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text('Add Couple Details',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              booked && bookings.length > 0
                                                  ? name1FormField()
                                                  : bookByNameFormField(),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: age1FormField()),
                                                  SizedBox(width: 5),
                                                  gender1FormField()
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              name2FormField(),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  age2FormField(),
                                                  SizedBox(width: 5),
                                                  gender2FormField()
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    addClicked = false;
                                                  });
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                color: Colors.grey[400],
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  if (validateAndSave()) {
                                                    booked &&
                                                            bookings.length > 0
                                                        ? addCouplesBooking(
                                                            name1)
                                                        : addCouplesBooking(
                                                            bookingByName);
                                                    setState(() {
                                                      if (!booked)
                                                        booked = !booked;
                                                      addClicked = false;
                                                      totalPrice +=
                                                          int.parse(price1);
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
                                                        BorderRadius.circular(
                                                            5)),
                                                color: kPrimaryColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: Text('Add Stag Pass',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              booked && bookings.length > 0
                                                  ? name1FormField()
                                                  : bookByNameFormField(),
                                              SizedBox(height: 5),
                                              age1FormField(),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    addClicked = false;
                                                  });
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                color: Colors.grey[400],
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  if (validateAndSave()) {
                                                    booked &&
                                                            bookings.length > 0
                                                        ? addStagBooking(name1)
                                                        : addStagBooking(
                                                            bookingByName);
                                                    setState(() {
                                                      if (!booked)
                                                        booked = !booked;
                                                      addClicked = false;
                                                      totalPrice +=
                                                          int.parse(price1);
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
                                                        BorderRadius.circular(
                                                            5)),
                                                color: kPrimaryColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                          )
                        : Container(),
                    booked && bookings.length > 0
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: List.generate(
                                bookings.length,
                                (index) => Dismissible(
                                  key: Key(bookings[index].toString()),
                                  onDismissed: (direction) {
                                    // print(index);
                                    // print(bookings[index].toString());
                                    setState(() {
                                      totalPrice -=
                                          int.parse(bookings[index]['price']);
                                    });
                                    bookings.removeAt(index);
                                    String action = "discarded";
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("booking $action"),
                                      ),
                                    );
                                  },
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Colors.red,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    margin: EdgeInsets.symmetric(vertical: 2),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black54),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                    ),
                                    child: ClipRRect(
                                      child: bookings[index]['passCategory'] ==
                                              "Couples"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Couple\'s Entry, ',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                          bookings[index]
                                                              ['passType'],
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                          ', ₹${bookings[index]['price']}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          bookings[index]
                                                                  ['maleName'] +
                                                              ',',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          bookings[index][
                                                                  'maleGender'] +
                                                              ',',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          bookings[index]
                                                              ['maleAge'],
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          bookings[index][
                                                                  'femaleName'] +
                                                              ',',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          bookings[index][
                                                                  'femaleGender'] +
                                                              ',',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          bookings[index]
                                                              ['femaleAge'],
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .arrow_back,
                                                                  color: Colors
                                                                      .black54,
                                                                  size: 15,
                                                                ),
                                                                Text(
                                                                  ' Swipe left to discard this booking',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Single Entry, ',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                          bookings[index]
                                                              ['passType'],
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                          ', ₹${bookings[index]['price']}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          bookings[index]
                                                                  ['name'] +
                                                              ',',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          bookings[index]
                                                                  ['gender'] +
                                                              ',',
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          bookings[index]
                                                              ['age'],
                                                          style: TextStyle(
                                                              fontSize: 17),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .arrow_back,
                                                                  color: Colors
                                                                      .black54,
                                                                  size: 15,
                                                                ),
                                                                Text(
                                                                  ' Swipe left to discard this booking',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Text('You have not added any bookings yet'),
                    SizedBox(height: 50)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(5),
                        child: FlatButton(
                          onPressed: () async {
                            bool paymentSuccess = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MakePayment(
                                    event: widget.event,
                                    totalAmount: totalPrice),
                              ),
                            );
                            if (!paymentSuccess) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Payment error, try again."),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Proceed to pay ₹${totalPrice.toString()}',
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

  TextFormField age1FormField() {
    return TextFormField(
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
        items: ['Female', 'Male', 'Others']
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

class ListofEntryPrices extends StatelessWidget {
  const ListofEntryPrices({
    Key key,
    @required this.widget,
    this.passType,
  }) : super(key: key);

  final Map widget;
  final String passType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 12,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/Cash.svg",
                height: 12,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                passType,
                style: TextStyle(fontSize: 17, color: Colors.black87),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.entries
              .map<Widget>(
                (e) => e.value.toString() == "Not Available"
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                e.key + " : ",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "₹ " + e.value.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              onPressed: () {})
                        ],
                      ),
              )
              .toList(),
        ),
      ],
    );
  }
}
