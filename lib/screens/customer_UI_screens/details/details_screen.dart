import 'package:bookario/models/Clubs.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ClubDetailsArguments agrs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Body(club: agrs.club),
    );
  }
}

class ClubDetailsArguments {
  final Club club;

  ClubDetailsArguments({@required this.club});
}
