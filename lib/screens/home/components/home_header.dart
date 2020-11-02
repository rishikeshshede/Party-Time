import 'package:flutter/material.dart';

import '../../../size_config.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(55),
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(8)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                "assets/images/onlylogo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "Home",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: getProportionateScreenHeight(55),
          )
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Bell.svg",
          //   numOfitem: 3,
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}
