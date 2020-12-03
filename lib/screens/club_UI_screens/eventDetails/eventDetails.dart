import 'package:flutter/material.dart';
import 'components/body.dart';

class EventDetailsScreen extends StatelessWidget {
  static String routeName = "/eventDetails";
  final int eventId;

  const EventDetailsScreen({Key key, this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(eventId: eventId),
    );
  }
}
