import 'package:bookario/models/Clubs.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class OwnClubDetailsScreen extends StatelessWidget {
  static String routeName = "/ownClubDetails";

  @override
  Widget build(BuildContext context) {
    final ClubDetailsArguments agrs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      body: Body(club: agrs.club),
    );
  }
}

class ClubDetailsArguments {
  final Club club;

  ClubDetailsArguments({@required this.club});
}
