import 'package:flutter/material.dart';

import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final EventDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Body(event: agrs.event),
    );
  }
}

class EventDetailsArguments {
  final event;

  EventDetailsArguments({@required this.event});
}
