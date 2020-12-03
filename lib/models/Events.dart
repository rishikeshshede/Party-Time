import 'package:flutter/material.dart';

class Event {
  final int id, male, female;
  final String eventName, address, location, description, time, date;
  final List<String> images;
  final couples, maleStag, femaleStag;

  Event({
    @required this.id,
    @required this.images,
    @required this.eventName,
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

// Our demo Events

List<Event> demoEvents = [
  Event(
    id: 1,
    images: [
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
    ],
    eventName: "Mi-A-Mi - JW Marriott",
    description: description,
    address: "JW Marriott, Senapati Bapat Road, Shivajinagar, Pune",
    date: "10-Dec-2020",
    time: "7 PM",
    location: "Shivajinagar",
    male: 9,
    female: 5,
    couples: {
      'Only Entry': '499',
      'Cover type 1': '599',
      'Cover type 2': '849',
      'Cover type 3': '1000'
    },
    maleStag: {
      'Only Entry': '600',
      'Cover type 1': '1200',
    },
    femaleStag: {
      'Only Entry': '549',
      'Cover type 1': '900',
      'Cover type 2': '1400'
    },
  ),
  Event(
    id: 2,
    images: [
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
    ],
    eventName: "Penthouze",
    description: description,
    address:
        "Onyx Tower, Next To Westin Hotel, North Main Road, Koregaon Park Annexe, Mundhwa, Pune",
    date: "05-Dec-2020",
    time: "8 PM",
    location: "Mundhwa",
    male: 12,
    female: 15,
    couples: {
      'Only Entry': '699',
      'Cover type 1': '599',
      'Cover type 2': '1000'
    },
    maleStag: {
      'Only Entry': '759',
      'Cover type 1': '900',
      'Cover type 2': '1200'
    },
    femaleStag: {
      'Only Entry': '799',
      'Cover type 1': '900',
      'Cover type 2': '1400'
    },
  ),
  Event(
    id: 3,
    images: [
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
    ],
    eventName: "Publiq",
    description: description,
    address:
        "White Square, 9th Floor, 901, Hinjewadi Phase 1 Road, Hinjewadi, Pune",
    date: "22-Nov-2020",
    time: "7:30 PM",
    location: "Hinjewadi",
    male: 11,
    female: 11,
    couples: {
      'Only Entry': '299.0',
      'Cover type 1': '699',
      'Cover type 2': '599',
      'Cover type 3': '1000',
      'Cover type 4': '1600'
    },
    maleStag: {
      'Only Entry': '299.0',
      'Cover type 1': '759',
      'Cover type 2': '900',
      'Cover type 3': '1200'
    },
    femaleStag: {
      'Only Entry': '299.0',
      'Cover type 1': '799',
      'Cover type 2': '900',
      'Cover type 3': '1400'
    },
  ),
  Event(
    id: 4,
    images: [
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
    ],
    eventName: "Oak Lounge",
    description: description,
    address: "Marriott Suites Pune, 81, Mundhwa, Pune",
    date: "31-Dec-2020",
    time: "7 PM",
    location: "Mundhwa",
    male: 39,
    female: 45,
    couples: {'Only Entry': '1499.0', 'Cover type 1': '1600'},
    maleStag: {'Only Entry': '2599.0'},
    femaleStag: {'Only Entry': '2249.0'},
  ),
  Event(
    id: 5,
    images: [
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
    ],
    eventName: "Mi-A-Mi - JW Marriott",
    description: description,
    address: "JW Marriott, Senapati Bapat Road, Shivajinagar, Pune",
    date: "10-Dec-2020",
    time: "7 PM",
    location: "Shivajinagar",
    male: 9,
    female: 5,
    couples: {
      'Only Entry': '499',
      'Cover type 1': '599',
      'Cover type 2': '849',
      'Cover type 3': '1000'
    },
    maleStag: {'Only Entry': '600', 'Cover type 1': '1200'},
    femaleStag: {
      'Only Entry': '549',
      'Cover type 1': '900',
      'Cover type 2': '1400'
    },
  ),
  Event(
    id: 6,
    images: [
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
    ],
    eventName: "Penthouze",
    description: description,
    address:
        "Onyx Tower, Next To Westin Hotel, North Main Road, Koregaon Park Annexe, Mundhwa, Pune",
    date: "05-Dec-2020",
    time: "8 PM",
    location: "Mundhwa",
    male: 12,
    female: 15,
    couples: {
      'Only Entry': '699',
      'Cover type 1': '599',
      'Cover type 2': '1000'
    },
    maleStag: {
      'Only Entry': '759',
      'Cover type 1': '900',
      'Cover type 2': '1200'
    },
    femaleStag: {
      'Only Entry': '799',
      'Cover type 1': '900',
      'Cover type 2': '1400'
    },
  ),
  Event(
    id: 7,
    images: [
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
    ],
    eventName: "Publiq",
    description: description,
    address:
        "White Square, 9th Floor, 901, Hinjewadi Phase 1 Road, Hinjewadi, Pune",
    date: "22-Nov-2020",
    time: "7:30 PM",
    location: "Hinjewadi",
    male: 11,
    female: 11,
    couples: {
      'Only Entry': '299.0',
      'Cover type 1': '699',
      'Cover type 2': '599',
      'Cover type 3': '1000',
      'Cover type 4': '1600'
    },
    maleStag: {
      'Only Entry': '299.0',
      'Cover type 1': '759',
      'Cover type 2': '900',
      'Cover type 3': '1200'
    },
    femaleStag: {
      'Only Entry': '299.0',
      'Cover type 1': '799',
      'Cover type 2': '900',
      'Cover type 3': '1400'
    },
  ),
  Event(
    id: 8,
    images: [
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
      "assets/images/dummyPub1.jpg",
    ],
    eventName: "Oak Lounge",
    description: description,
    address: "Marriott Suites Pune, 81, Mundhwa, Pune",
    date: "31-Dec-2020",
    time: "7 PM",
    location: "Mundhwa",
    male: 39,
    female: 45,
    couples: {'Only Entry': '1499.0', 'Cover type 1': '1600'},
    maleStag: {'Only Entry': '2599.0'},
    femaleStag: {'Only Entry': '2249.0'},
  )
];

const String description =
    "Publiq has free entry through the week and offers ladies night on Wednesdays. If you're one who loves dancing to Bollywood songs, then you must hit the club on a Friday night. Publiq has three locations in Pune, each offering a refined crowd that's both fun; and pours good alcohol. You will always find some or the other deal at the bar or on food, so your experience here will be better.";

Map<String, double> dataMap = {
  "Male Stag": 8,
  "Female Stag": 7,
  "Couples": 10,
};
