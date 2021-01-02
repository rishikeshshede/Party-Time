import 'package:flutter/material.dart';

import 'size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        Container(
          height: 32,
          width: 32,
          margin: EdgeInsets.only(right: 10, top: 0),
          decoration: BoxDecoration(
            color: Colors.grey[350],
            borderRadius: BorderRadius.circular(6),
          ),
          child: IconButton(
            icon: Icon(
              Icons.sort,
              size: 20,
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
