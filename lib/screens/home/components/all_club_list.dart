import 'package:bookario/screens/home/components/home_club_card.dart';
import 'package:bookario/models/Product.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../components/section_title.dart';

class Clubs extends StatefulWidget {
  @override
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)),
          child: SectionTitle(title: "Clubs in Pune", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(10)),
        SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                demoClubs.length,
                (index) {
                  return HomeClubCard(club: demoClubs[index]);
                },
              ),
              SizedBox(width: getProportionateScreenWidth(10)),
            ],
          ),
        )
      ],
    );
  }
}
