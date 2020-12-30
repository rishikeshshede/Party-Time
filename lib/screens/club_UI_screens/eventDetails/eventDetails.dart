import 'package:flutter/material.dart';
import 'components/body.dart';

class EventDetailsScreen extends StatelessWidget {
  static String routeName = "/eventDetails";
  final event;

  const EventDetailsScreen({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(event: event),
    );
  }
}
