import 'package:bookario/components/default_button.dart';
import 'package:bookario/constants.dart';
import 'package:bookario/screens/club_UI_screens/details/components/all_prices.dart';
import 'package:bookario/screens/club_UI_screens/details/components/custom_app_bar.dart';
import 'package:bookario/screens/club_UI_screens/details/components/row_display.dart';
import 'package:flutter/material.dart';
import 'package:bookario/models/Clubs.dart';
import 'package:bookario/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'pie_chart_view.dart';

class Body extends StatelessWidget {
  final Club club;

  const Body({Key key, @required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(title: club.clubName, location: club.location),
                ChartView(club: club),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RowDisplay(
                            icon: "assets/icons/group.svg",
                            title: "Total Bookings :  ",
                            value: (club.male + club.female).toString(),
                          ),
                          RowDisplay(
                            icon: "assets/icons/m-f.svg",
                            title: "Male / Female : ",
                            value: club.male.toString() +
                                " / " +
                                club.female.toString(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Earnings\n",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: "₹ " +
                                  (club.male * 1000 + club.female * 1500)
                                      .toString(),
                              style: TextStyle(color: kSecondaryColor),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.orientation == Orientation.portrait
                            ? SizeConfig.screenHeight * .1
                            : SizeConfig.screenHeight * .2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white70,
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.15,
                  right: SizeConfig.screenWidth * 0.15,
                  bottom: getProportionateScreenWidth(10),
                  top: getProportionateScreenWidth(2),
                ),
                child: DefaultButton(
                  text: "View Bookings",
                  press: () {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
