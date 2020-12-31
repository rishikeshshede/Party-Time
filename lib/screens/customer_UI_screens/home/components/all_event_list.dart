import 'package:bookario/components/networking.dart';
import 'package:bookario/components/section_title.dart';
import 'package:bookario/screens/customer_UI_screens/home/components/home_club_card.dart';
import 'package:flutter/material.dart';

import '../../../../components/size_config.dart';

class Clubs extends StatefulWidget {
  @override
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  int offset, limit;
  List<dynamic> eventData;
  bool hasEvents = false,
      homeLoading = true,
      loadMore = false,
      loadingMore = false;

  @override
  void initState() {
    getAllEvents();
    offset = 0;
    limit = 10;
    super.initState();
  }

  getAllEvents() async {
    try {
      var response = await Networking.getData('events/get-all-events', {
        "limit": limit.toString(),
        "offset": offset.toString(),
      });
      print(response['data'].length);
      if (response['data'].length > 0) {
        setState(() {
          hasEvents = true;
          loadMore = true;
          loadingMore = false;
          eventData = response['data'];
        });
        print(eventData[0]);
      } else {
        setState(() {
          homeLoading = false;
          loadMore = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8)),
          child: SectionTitle(title: "Clubs in Pune"),
        ),
        SizedBox(height: getProportionateScreenWidth(10)),
        SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                eventData.length,
                (index) {
                  return HomeEventCard(eventData: eventData[index]);
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
