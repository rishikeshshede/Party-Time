import 'package:bookario/components/constants.dart';
import 'package:bookario/components/default_button.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/screens/club_UI_screens/details/components/add_event.dart';
import 'package:bookario/screens/club_UI_screens/details/components/club_description.dart';
import 'package:bookario/screens/club_UI_screens/details/components/club_events.dart';
import 'package:bookario/screens/club_UI_screens/details/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bookario/components/size_config.dart';

class Body extends StatefulWidget {
  final club;
  const Body({Key key, @required this.club}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool hasEvents = false,
      eventLoading = true,
      loadMore = false,
      loadingMore = false;
  int offset, limit;
  List<dynamic> eventData;

  @override
  void initState() {
    offset = 0;
    limit = 10;
    getMyEvents();
    super.initState();
  }

  getMyEvents() async {
    // String clubId = await PersistenceHandler.getter('clubId');
    // print('ClubID: $clubId');
    try {
      var response = await Networking.getData('events/get-club-event', {
        "clubId": widget.club['clubId'].toString(),
        "limit": limit.toString(),
        "offset": offset.toString(),
      });
      // print(response['data']);
      if (response['data'].length > 0) {
        setState(() {
          hasEvents = true;
          // eventLoading = false;
          loadMore = true;
          loadingMore = false;
          eventData = response['data'];
        });
        print(eventData);
      } else {
        setState(() {
          eventLoading = false;
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
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                    title: widget.club['name'],
                    location: widget.club['location']),
                ClubDescription(club: widget.club),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 6,
                            bottom: 18,
                          ),
                          child: Text(
                            "Upcoming events",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          ),
                        ),
                      ),
                      hasEvents
                          ? showEvents(context)
                          : eventLoading
                              ? Loading()
                              : Container(
                                  alignment: Alignment.center,
                                  child: Text('No Events.'),
                                ),
                      SizedBox(height: 80),
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
                  text: "Add Event",
                  press: () async {
                    bool eventAdded = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEvent(club: widget.club),
                      ),
                    );
                    if (eventAdded) {
                      getMyEvents();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView showEvents(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClubEvents(eventData: eventData),
          SizedBox(width: getProportionateScreenWidth(10)),
          loadMore
              ? loadingMore
                  ? Loading()
                  : FlatButton(
                      onPressed: () {
                        setState(() {
                          loadingMore = true;
                          offset += limit;
                        });
                        getMyEvents();
                      },
                      child: Text(
                        'load more',
                      ),
                      splashColor: Theme.of(context).primaryColorLight,
                    )
              : Container(),
          SizedBox(height: getProportionateScreenWidth(10)),
        ],
      ),
    );
  }
}
