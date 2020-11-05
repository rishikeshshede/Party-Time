import 'package:flutter/material.dart';

class History {
  final String clubName, address, location, bookingDate;
  final double amountPaid;

  History({
    @required this.clubName,
    @required this.address,
    @required this.location,
    @required this.bookingDate,
    @required this.amountPaid,
  });
}

List<History> clubsBooked = [
  History(
    clubName: 'Penthouze',
    address:
        'Onyx Tower, Next To Westin Hotel, North Main Road, Koregaon Park Annexe, Mundhwa, Pune',
    location: 'Mundhwa',
    bookingDate: '05-Dec-2020',
    amountPaid: 1500,
  ),
  History(
    clubName: 'Oak Lounge',
    address: 'Marriott Suites Pune, 81, Mundhwa, Pune',
    location: 'Mundhwa',
    bookingDate: '31-Dec-2020',
    amountPaid: 3500,
  ),
];
