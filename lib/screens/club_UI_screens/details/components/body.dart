import 'package:bookario/components/default_button.dart';
import 'package:bookario/constants.dart';
import 'package:bookario/screens/club_UI_screens/details/components/all_prices.dart';
import 'package:bookario/screens/club_UI_screens/details/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bookario/models/Clubs.dart';
import 'package:bookario/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'club_description.dart';
import 'club_images.dart';

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
                ClubImages(club: club),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(40),
                    //   topRight: Radius.circular(40),
                    // ),
                  ),
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

class RowDisplay extends StatelessWidget {
  const RowDisplay({
    Key key,
    @required this.title,
    @required this.value,
    this.icon,
  }) : super(key: key);

  final String title;
  final String value;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          height: 15,
        ),
        const SizedBox(
          width: 5,
        ),
        RichText(
          text: TextSpan(
            text: title,
            style: TextStyle(color: kPrimaryColor, fontSize: 16),
            children: [
              TextSpan(
                text: value,
                style: TextStyle(color: kSecondaryColor),
              )
            ],
          ),
        ),
      ],
    );
  }
}
