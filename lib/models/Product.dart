import 'package:flutter/material.dart';

class Club {
  final int id, male, female;
  final String name, address, location, description, time, date;
  final List<String> images, couples, maleStag, femaleStag;

  Club({
    @required this.id,
    @required this.images,
    @required this.name,
    @required this.description,
    @required this.address,
    @required this.location,
    @required this.date,
    @required this.time,
    @required this.male,
    @required this.female,
    this.couples,
    this.maleStag,
    this.femaleStag,
  });
}

// Our demo Clubs

List<Club> demoClubs = [
  Club(
    id: 1,
    images: [
      "assets/images/Buffer-rafiki.png",
      "assets/images/jockey-rafiki.png",
      "assets/images/Buffer-rafiki.png",
      "assets/images/jockey-rafiki.png",
    ],
    name: "Mi-A-Mi - JW Marriott",
    description: description,
    address: "JW Marriott, Senapati Bapat Road, Shivajinagar, Pune",
    date: "10-Dec-2020",
    time: "7 PM",
    location: "Shivajinagar",
    male: 9,
    female: 5,
    couples: ['499', '599', '849', '1000'],
    maleStag: ['600', '1200'],
    femaleStag: ['549', '900', '1400'],
  ),
  Club(
    id: 2,
    images: [
      "assets/images/jockey-rafiki.png",
      "assets/images/Buffer-rafiki.png",
    ],
    name: "Penthouze",
    description: description,
    address:
        "Onyx Tower, Next To Westin Hotel, North Main Road, Koregaon Park Annexe, Mundhwa, Pune",
    date: "05-Dec-2020",
    time: "8 PM",
    location: "Mundhwa",
    male: 12,
    female: 15,
    couples: ['699', '599', '1000'],
    maleStag: ['759', '900', '1200'],
    femaleStag: ['799', '900', '1400'],
  ),
  Club(
    id: 3,
    images: [
      "assets/images/Buffer-rafiki.png",
      "assets/images/jockey-rafiki.png",
    ],
    name: "Publiq",
    description: description,
    address:
        "White Square, 9th Floor, 901, Hinjewadi Phase 1 Road, Hinjewadi, Pune",
    date: "22-Nov-2020",
    time: "7:30 PM",
    location: "Hinjewadi",
    male: 11,
    female: 11,
    couples: ['299.0', '699', '599', '1000', '1600'],
    maleStag: ['299.0', '759', '900', '1200'],
    femaleStag: ['299.0', '799', '900', '1400'],
  ),
  Club(
    id: 4,
    images: [
      "assets/images/jockey-rafiki.png",
      "assets/images/Buffer-rafiki.png",
      "assets/images/jockey-rafiki.png",
    ],
    name: "Oak Lounge",
    description: description,
    address: "Marriott Suites Pune, 81, Mundhwa, Pune",
    date: "31-Dec-2020",
    time: "7 PM",
    location: "Mundhwa",
    male: 39,
    female: 45,
    couples: ['1499.0', '1600'],
    maleStag: ['2599.0'],
    femaleStag: ['2249.0'],
  ),
];

const String description =
    "Publiq has free entry through the week and offers ladies night on Wednesdays. If you're one who loves dancing to Bollywood songs, then you must hit the club on a Friday night. Publiq has three locations in Pune, each offering a refined crowd that's both fun; and pours good alcohol. You will always find some or the other deal at the bar or on food, so your experience here will be better.";
