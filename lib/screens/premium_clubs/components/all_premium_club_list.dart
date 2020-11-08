import 'package:bookario/components/section_title.dart';
import 'package:bookario/models/Product.dart';
import 'package:bookario/screens/premium_clubs/components/premium_club_card.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class PremiumClubs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double itemWidth = SizeConfig.screenWidth / 2;

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(6)),
          child: SectionTitle(title: " Premium Clubs in Pune", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(10)),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemWidth),
                  controller: new ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: List.generate(demoClubs.length, (index) {
                    return PremiumClubCard(club: demoClubs[index]);
                  }),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
