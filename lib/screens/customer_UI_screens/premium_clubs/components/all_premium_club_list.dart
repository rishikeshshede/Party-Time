import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/screens/customer_UI_screens/premium_clubs/components/premium_club_card.dart';
import 'package:flutter/material.dart';
import '../../../../components/size_config.dart';

class PremiumEvents extends StatefulWidget {
  @override
  _PremiumEventsState createState() => _PremiumEventsState();
}

class _PremiumEventsState extends State<PremiumEvents> {
  int offset, limit;
  List<dynamic> eventData = [], locations;
  List<String> allLocations = [];
  bool hasEvents, screenLoading, loadMore, loadingMore, filterApplied;
  String _location = 'Kondhwa';

  @override
  void initState() {
    hasEvents = false;
    screenLoading = true;
    loadMore = false;
    loadingMore = false;
    filterApplied = false;
    offset = 0;
    limit = 10;
    getPremiumEvents();
    getAllLocations();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getPremiumEvents() async {
    try {
      var response = await Networking.getData('events/get-premium-event', {
        "limit": limit.toString(),
        "offset": offset.toString(),
      });
      if (response['data'].length > 0) {
        print(response['data'].length);
        setState(() {
          hasEvents = true;
          loadMore = true;
          loadingMore = false;
          eventData += response['data'];
        });
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

  getAllLocations() async {
    try {
      var response =
          await Networking.getData('events/get-unique-locations', {});
      if (response['data'].length > 0) {
        setState(() {
          locations = response['data'];
          for (int i = 0; i < locations.length; i++) {
            addLocation(locations[i]);
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void addLocation(uniqueLocation) {
    setState(() {
      allLocations.add(uniqueLocation['location']);
    });
  }

  getPremiumEventsByLocation() async {
    setState(() {
      hasEvents = false;
    });
    try {
      var response =
          await Networking.getData('events/get-premium-event-by-location', {
        "location": _location,
        "limit": limit.toString(),
        "offset": offset.toString(),
      });
      if (response['data'].length > 0) {
        if (!filterApplied) {
          setState(() {
            filterApplied = true;
            hasEvents = true;
            loadMore = true;
            loadingMore = false;
            eventData = response['data'];
          });
        } else {
          setState(() {
            hasEvents = true;
            loadMore = true;
            loadingMore = false;
            eventData += response['data'];
          });
        }
      } else {
        setState(() {
          hasEvents = true;
          loadMore = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double itemWidth = SizeConfig.screenWidth / 2;

    return Column(
      children: [
        hasEvents
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Premium Events in Pune",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.white70,
                      ),
                    ),
                    Container(
                      height: 32,
                      width: 32,
                      margin: EdgeInsets.only(right: 10, top: 0),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.sort,
                          size: 20,
                        ),
                        onPressed: () {
                          filterSearchDialog(context);
                        },
                      ),
                    )
                  ],
                ),
              )
            : Container(),
        SizedBox(height: getProportionateScreenWidth(10)),
        hasEvents
            ? Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: (itemWidth / itemWidth),
                            controller:
                                new ScrollController(keepScrollOffset: false),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: List.generate(eventData.length, (index) {
                              return PremiumEventCard(event: eventData[index]);
                            }),
                          ),
                        ],
                      ),
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
                                !filterApplied
                                    ? getPremiumEvents()
                                    : getPremiumEventsByLocation();
                              },
                              child: Text(
                                'load more',
                              ),
                              splashColor: Theme.of(context).primaryColorLight,
                            )
                      : Container(),
                ],
              )
            : screenLoading
                ? Loading()
                : Column(
                    children: [
                      Text(
                        'No premium events listed yet.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
      ],
    );
  }

  Future<bool> filterSearchDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          title: Text('Apply Search Filter',
              style: TextStyle(
                  fontSize: 17,
                  letterSpacing: 0.7,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          content: Row(
            children: [
              Text('Location: ', style: TextStyle(color: Colors.white)),
              selectLocation()
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontSize: 14, letterSpacing: .8, color: Colors.white),
              ),
              splashColor: Theme.of(context).primaryColorLight,
              color: Colors.grey[400],
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                getPremiumEventsByLocation();
              },
              child: Text(
                'Apply',
                style: TextStyle(
                    fontSize: 14, letterSpacing: .8, color: Colors.white),
              ),
              splashColor: Theme.of(context).primaryColorLight,
              color: Theme.of(context).primaryColor,
            ),
          ],
        );
      },
    );
  }

  Expanded selectLocation() {
    return Expanded(
      child: DropdownButtonFormField<String>(
        value: _location,
        isExpanded: false,
        onChanged: (String value) {
          setState(() {
            _location = value;
          });
          print(_location);
        },
        items: allLocations.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
        validator: (value) => value == null ? 'Select Location' : null,
        decoration: InputDecoration(
          labelText: 'Select',
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
