import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/screens/customer_UI_screens/history/components/booked_club_card.dart';
import 'package:flutter/material.dart';

import '../../../../components/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int limit, offset;
  List<dynamic> bookingData = [];
  var clubData;
  bool hasBookings = false,
      screenLoading = true,
      loadMore = false,
      loadingMore = false;

  @override
  void initState() {
    offset = 0;
    limit = 10;
    getBookingData();
    super.initState();
  }

  getBookingData() async {
    String uid = await PersistenceHandler.getter('uid');
    try {
      var response = await Networking.getData('bookings/get-user-bookings', {
        "userId": uid,
        "limit": limit.toString(),
        "offset": offset.toString(),
      });
      print(response);
      if (response['data'].length > 0) {
        // var clubResponse = await Networking.getData('clubs/get-club-details',
        //     {"clubId": response['data']['clubId'].toString()});
        // print(clubResponse);
        setState(() {
          hasBookings = true;
          loadMore = true;
          loadingMore = false;
          bookingData += response['data'];
          // clubData = clubResponse['data'];
        });
        print(bookingData.length);
      } else {
        setState(() {
          screenLoading = false;
          loadMore = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(5)),
              hasBookings
                  ? Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                bookingData.length,
                                (index) {
                                  return BookedEventCard(
                                    bookingData: bookingData[index],
                                    // clubData: clubData,
                                  );
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(20)),
                            ],
                          ),
                        ),
                        loadMore
                            ? loadingMore
                                ? Loading()
                                : FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        offset += limit;
                                        loadingMore = true;
                                      });
                                      getBookingData();
                                    },
                                    child: Text(
                                      'load more',
                                    ),
                                    splashColor:
                                        Theme.of(context).primaryColorLight,
                                  )
                            : Container(),
                      ],
                    )
                  : screenLoading
                      ? Loading()
                      : Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Your bookings will be available here\nwhen you book an event.',
                            textAlign: TextAlign.center,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
