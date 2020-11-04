import 'package:bookario/screens/details/components/displayPrices.dart';
import 'package:flutter/material.dart';
import 'package:bookario/models/Product.dart';

class AllPrices extends StatefulWidget {
  const AllPrices({
    Key key,
    @required this.club,
  }) : super(key: key);

  final Club club;

  @override
  _AllPricesState createState() => _AllPricesState();
}

class _AllPricesState extends State<AllPrices> {
  @override
  Widget build(BuildContext context) {
    // print(widget.club.couples['Only Entry']);
    return DisplayPrices(widget: widget);
  }
}

class DisplayPrices extends StatelessWidget {
  const DisplayPrices({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final AllPrices widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListofEntryPrices(widget: widget.club.couples, passType: "Couple Pass"),
        ListofEntryPrices(
            widget: widget.club.maleStag, passType: "Male Stag Pass"),
        ListofEntryPrices(
            widget: widget.club.femaleStag, passType: "Female Stag Pass"),
      ],
    );
  }
}
