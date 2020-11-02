import 'package:bookario/screens/home/components/home_club_card.dart';
import 'package:bookario/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
          child: SectionTitle(
            title: "Clubs in Pune",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(15)),
        SingleChildScrollView(
          child: Column(
            children: [
              HomeClubCard(
                image: "assets/images/jockey-rafiki.png",
                clubName: "XYZ Club",
                address: "XYZ Club, Magarpatta",
                press: () {},
              ),
              SizedBox(
                height: getProportionateScreenHeight(12),
              ),
              HomeClubCard(
                image: "assets/images/Buffer-rafiki.png",
                clubName: "ABC Club",
                address: "ABC Club, Hingewadi",
                press: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}
