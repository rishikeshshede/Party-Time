import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class BookingList extends StatefulWidget {
  const BookingList({
    Key key,
    @required this.bookingList,
  }) : super(key: key);

  final List<Map> bookingList;

  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  // void removeError({String error}) {
  //   if (errors.contains(error))
  //     setState(() {
  //       errors.remove(error);
  //     });
  // }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.bookingList.length,
          (index) => bookingListText(data: widget.bookingList[index])),
    );
  }

  Container bookingListText({Map data}) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  data['name'] + ',',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(width: 10),
                Text(
                  data['gender'] + ',',
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(width: 10),
                Text(
                  data['age'],
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
