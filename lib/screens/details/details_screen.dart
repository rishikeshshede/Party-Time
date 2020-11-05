import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ClubDetailsArguments agrs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      // backgroundColor: Color(0xFFF5F6F9),
      body: Body(club: agrs.club),
    );
  }
}

class ClubDetailsArguments {
  final Club club;

  ClubDetailsArguments({@required this.club});
}
