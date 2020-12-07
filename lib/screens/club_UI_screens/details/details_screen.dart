import 'package:flutter/material.dart';

import 'components/body.dart';

class OwnClubDetailsScreen extends StatelessWidget {
  static String routeName = "/ownClubDetails";

  @override
  Widget build(BuildContext context) {
    final ClubDetailsArguments agrs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Body(club: agrs.club),
    );
  }
}

class ClubDetailsArguments {
  final club;

  ClubDetailsArguments({@required this.club});
}
