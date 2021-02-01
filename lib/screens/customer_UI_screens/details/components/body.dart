import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/hoveringBackButton.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/screens/customer_UI_screens/bookings/bookPass.dart';
import 'package:flutter/material.dart';
import 'package:bookario/components/size_config.dart';

import 'club_description.dart';
import 'club_images.dart';

class Body extends StatefulWidget {
  final event;

  const Body({Key key, @required this.event}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<dynamic> clubData;
  bool loadingClubDetails = true;

  @override
  void initState() {
    getClubDetails();
    super.initState();
  }

  getClubDetails() async {
    try {
      var response = await Networking.getData('clubs/get-club-details', {
        'clubId': widget.event['clubId'].toString(),
      });
      print(response);
      if (response['data'].length > 0) {
        setState(() {
          clubData = response['data'];
          loadingClubDetails = false;
        });
        print(clubData);
      }
    } catch (e) {
      print(e);
    }
  }

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
                    ClubImage(
                        // clubId: widget.event['clubId'],
                        image: widget.event['image'],
                        eventId: widget.event['eventId']),
                    HoveringBackButton(),
                  ],
                ),
                loadingClubDetails
                    ? Loading()
                    : Container(
                        margin: EdgeInsets.only(
                            top: getProportionateScreenWidth(10)),
                        padding: EdgeInsets.only(
                            top: getProportionateScreenWidth(15),
                            left: getProportionateScreenWidth(20),
                            right: getProportionateScreenWidth(20)),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              clubData[0]['name'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontSize: getProportionateScreenWidth(16),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              '(${clubData[0]['location']})',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            EventDescription(
                              event: widget.event,
                              clubData: clubData[0],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            // TODO: Display remaining stags here
                            SizedBox(height: 60),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white12,
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.15,
                  right: SizeConfig.screenWidth * 0.15,
                  bottom: getProportionateScreenWidth(5),
                  top: getProportionateScreenWidth(5),
                ),
                child: DefaultButton(
                  text: "Get Pass",
                  press: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookPass(event: widget.event)))
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
