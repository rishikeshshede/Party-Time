import 'package:bookario/components/constants.dart';
import 'package:bookario/screens/customer_UI_screens/profile/components/contact_tile.dart';
import 'package:bookario/screens/customer_UI_screens/profile/components/logout_tile.dart';
import 'package:bookario/screens/customer_UI_screens/profile/components/refer_a_friend_tile.dart';
import 'package:bookario/screens/customer_UI_screens/profile/components/uesr_info.dart';
import 'package:bookario/screens/customer_UI_screens/profile/components/view_bookings_tile.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UserDetails(),
          divider(),
          ViewBookings(),
          divider(),
          ReferAFriendTile(),
          divider(),
          ContactTile(),
          divider(),
          LogoutTile(),
          divider(),
        ],
      ),
    );
  }
}
