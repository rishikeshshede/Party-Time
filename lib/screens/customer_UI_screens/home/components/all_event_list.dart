import 'package:bookario/components/constants.dart';
import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/screens/customer_UI_screens/home/components/home_club_card.dart';
import 'package:flutter/material.dart';

import '../../../../components/size_config.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  int offset, limit;
  List<dynamic> eventData = [], locations;
  List<String> allLocations = [];
  bool hasEvents = false,
      homeLoading = true,
      loadMore = false,
      loadingMore = false,
      filterApplied = false;
  String _location = 'Magerpatta';

  @override
  void initState() {
    offset = 0;
    limit = 10;
    getAllEvents();
    getAllLocations();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAllEvents() async {
    try {
      var response = await Networking.getData('events/get-all-events', {
        "limit": limit.toString(),
        "offset": offset.toString(),
      });
      if (response['data'].length > 0) {
        setState(() {
          hasEvents = true;
          loadMore = true;
          loadingMore = false;
          eventData += response['data'];
        });
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

  void addLocation(uniqueLocation) {
    setState(() {
      allLocations.add(uniqueLocation['location']);
    });
  }

  getAllLocations() async {
    try {
      var response =
          await Networking.getData('events/get-unique-locations', {});
      if (response['data'].length > 0) {
        setState(() {
          hasEvents = true;
          loadMore = true;
          loadingMore = false;
          locations = response['data'];
          for (int i = 0; i < locations.length; i++) {
            addLocation(locations[i]);
          }
        });
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

  getEventsByLocation() async {
    setState(() {
      hasEvents = false;
    });
    try {
      var response = await Networking.getData('events/get-event-by-location', {
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
    return Column(
      children: [
        hasEvents
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Events in Pune",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                                    ? getAllEvents()
                                    : getEventsByLocation();
                              },
                              child: Text(
                                'load more',
                                style: TextStyle(color: Colors.white38),
                              ),
                              splashColor: Theme.of(context).primaryColorLight,
                            )
                      : Container(),
                ],
              )
            : homeLoading
                ? Loading()
                : Container(
                    alignment: Alignment.center,
                    child: Text(
                      'No events listed yet.\n Please visit after sometime.',
                      textAlign: TextAlign.center,
                    ),
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
          title: Text('Filter by',
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
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                getEventsByLocation();
              },
              child: Text(
                'Apply',
                style: TextStyle(
                    fontSize: 14, letterSpacing: .8, color: Colors.white),
              ),
              splashColor: Theme.of(context).primaryColorLight,
              color: kSecondaryColor,
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
        style: TextStyle(color: Colors.white70),
        onChanged: (String value) {
          setState(() {
            _location = value;
          });
        },
        items: allLocations.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: kSecondaryColor),
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
