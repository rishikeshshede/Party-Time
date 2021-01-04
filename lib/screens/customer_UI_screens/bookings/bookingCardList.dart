import 'package:flutter/material.dart';

class BookingCardList extends StatelessWidget {
  const BookingCardList({
    Key key,
    @required this.bookings,
  }) : super(key: key);

  final List<Map> bookings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        bookings.length,
        (index) => Dismissible(
          key: ValueKey(index),
          onDismissed: (direction) {
            bookings.removeAt(index);
            String action = "discarded";
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("booking $action"),
              ),
            );
          },
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: AlignmentDirectional.centerEnd,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child:
              // bookingListText(data: bookings[index]),
              Container(
            // height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            margin: EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            child: ClipRRect(
              child: bookings[index]['passCategory'] == "Couples"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Couple\'s Entry, ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                Text(
                                  bookings[index]['passType'],
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  bookings[index]['maleName'] + ',',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  bookings[index]['maleGender'] + ',',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  bookings[index]['maleAge'],
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  bookings[index]['femaleName'] + ',',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  bookings[index]['femaleGender'] + ',',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  bookings[index]['femaleAge'],
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.black54,
                                          size: 15,
                                        ),
                                        Text(
                                          ' Swipe left to discard this booking',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Single Entry, ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                Text(
                                  bookings[index]['passType'],
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  bookings[index]['name'] + ',',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  bookings[index]['gender'] + ',',
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  bookings[index]['age'],
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.black54,
                                          size: 15,
                                        ),
                                        Text(
                                          ' Swipe left to discard this booking',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
