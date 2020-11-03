import 'package:flutter/material.dart';
import 'package:bookario/models/Product.dart';

import '../../../size_config.dart';

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
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenWidth(10),
          ),
          child: Text(
            "Couple Prices",
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
        // ListView.builder(
        //     itemCount: widget.club.couples.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Text(
        //         widget.club.couples[index],
        //       );
        //     }),
      ],
    );
  }
}
