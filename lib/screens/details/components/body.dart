import 'package:bookario/components/default_button.dart';
import 'package:bookario/screens/details/components/all_prices.dart';
import 'package:flutter/material.dart';
import 'package:bookario/models/Product.dart';
import 'package:bookario/size_config.dart';

import 'club_description.dart';
import 'product_images.dart';

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
                ProductImages(club: club),
                Container(
                  margin: EdgeInsets.only(top: getProportionateScreenWidth(10)),
                  padding: EdgeInsets.only(
                      top: getProportionateScreenWidth(15),
                      left: getProportionateScreenWidth(20),
                      right: getProportionateScreenWidth(20)),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      ClubDescription(
                        club: club,
                        pressOnSeeMore: () {},
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),

                      // TODO: Display remaining stags here

                      AllPrices(club: club),
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
                  text: "Get Pass",
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
