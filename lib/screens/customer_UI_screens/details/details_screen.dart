import 'package:flutter/material.dart';

import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ClubDetailsArguments agrs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Body(event: agrs.event),
    );
  }
}

class ClubDetailsArguments {
  final event;

  ClubDetailsArguments({@required this.event});
}
