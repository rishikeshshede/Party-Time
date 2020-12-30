import 'dart:convert';
import 'package:bookario/screens/customer_UI_screens/details/components/displayPrices.dart';
import 'package:flutter/material.dart';

class AllPricesString {
  IndividualPrices maleStag;
  IndividualPrices femaleStag;
  IndividualPrices couples;

  AllPricesString(this.maleStag, this.femaleStag, this.couples);

  factory AllPricesString.fromJson(dynamic json) {
    return AllPricesString(
        IndividualPrices.fromJson(json['maleStag']),
        IndividualPrices.fromJson(json['femaleStag']),
        IndividualPrices.fromJson(json['couples']));
  }

  @override
  String toString() {
    return '{ ${this.maleStag}, ${this.femaleStag}, ${this.couples} }';
  }
}

class IndividualPrices {
  String basicPass;
  String cover1;
  String cover2;
  String cover3;
  String cover4;

  IndividualPrices(
      this.basicPass, this.cover1, this.cover2, this.cover3, this.cover4);

  factory IndividualPrices.fromJson(dynamic json) {
    return IndividualPrices(
        json['Basic Pass'] as String,
        json['Cover type 1'] as String,
        json['Cover type 2'] as String,
        json['Cover type 3'] as String,
        json['Cover type 4'] as String);
  }

  @override
  String toString() {
    return '{ ${this.basicPass}, ${this.cover1}, ${this.cover2}, ${this.cover3}, ${this.cover4} }';
  }
}

class AllPrices extends StatefulWidget {
  const AllPrices({
    Key key,
    this.priceDescription,
  }) : super(key: key);

  final priceDescription;

  @override
  _AllPricesState createState() => _AllPricesState();
}

class _AllPricesState extends State<AllPrices> {
  static Map prices;
  AllPricesString user;
  @override
  void initState() {
    user = AllPricesString.fromJson(jsonDecode(widget.priceDescription));
    // prices = json.decode(widget.priceDescription);
    print(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.priceDescription)
        // ListofEntryPrices(widget: prices['couples'], passType: "Couple Pass"),
        // ListofEntryPrices(
        //     widget: prices['maleStag'], passType: "Male Stag Pass"),
        // ListofEntryPrices(
        //     widget: prices['femaleStag'], passType: "Female Stag Pass"),
      ],
    );
  }
}

// class DisplayPrices extends StatelessWidget {
//   const DisplayPrices({
//     Key key,
//     @required this.widget,
//   }) : super(key: key);

//   final AllPrices widget;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListofEntryPrices(
//             widget: widget.priceDescription['couples'],
//             passType: "Couple Pass"),
//         ListofEntryPrices(
//             widget: widget.priceDescription['maleStag'],
//             passType: "Male Stag Pass"),
//         ListofEntryPrices(
//             widget: widget.priceDescription['femaleStag'],
//             passType: "Female Stag Pass"),
//       ],
//     );
//   }
// }
