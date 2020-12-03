import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/hoveringBackButton.dart';
import 'package:bookario/models/Clubs.dart';
import 'package:bookario/models/Events.dart';
import 'package:bookario/screens/customer_UI_screens/details/components/all_prices.dart';
import 'package:bookario/screens/customer_UI_screens/eventDetails/components/event_description.dart';
import 'package:flutter/material.dart';
import 'package:bookario/components/size_config.dart';

class Body extends StatelessWidget {
  final int eventId;

  Body({Key key, @required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset('assets/images/dummyPub1.jpg'),
                    HoveringBackButton(),
                  ],
                ),
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
                      EventDescription(
                        event: demoEvents[eventId - 1],
                        pressOnSeeMore: () {},
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),

                      // TODO: Display remaining stags here
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                          ),
                          child: Text(
                            "Pass Prices",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                        ),
                      ),
                      AllPrices(club: demoClubs[0]),
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
                  press: () {
                    // TODO: booking ticket
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
