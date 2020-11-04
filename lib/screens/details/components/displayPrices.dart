import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

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
            top: getProportionateScreenWidth(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/Cash.svg",
                height: getProportionateScreenWidth(10),
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
                (e) => Row(
                  children: [
                    Text(
                      e.key + " : ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "₹ " + e.value,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
