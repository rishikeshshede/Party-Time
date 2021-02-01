import 'package:bookario/screens/customer_UI_screens/history/booking_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewBookings extends StatelessWidget {
  const ViewBookings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingHistory()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/tickets.svg",
                  height: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Bookings',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset("assets/icons/arrow_right.svg",
                  height: 14, fit: BoxFit.cover, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
