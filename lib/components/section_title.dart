import 'package:flutter/material.dart';

import 'size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    @required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        // GestureDetector(
        //   onTap: press,
        //   child: SizedBox(
        //     width: getProportionateScreenWidth(40),
        //     child: Column(
        //       children: [
        //         Container(
        //           padding: EdgeInsets.all(getProportionateScreenWidth(8)),
        //           height: getProportionateScreenWidth(35),
        //           width: getProportionateScreenWidth(35),
        //           decoration: BoxDecoration(
        //             color: Color(0xFFEAEAEA),
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           child: SvgPicture.asset('assets/icons/filter.svg'),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
