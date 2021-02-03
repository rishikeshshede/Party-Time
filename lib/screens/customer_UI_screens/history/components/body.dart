import 'dart:convert';

import 'package:bookario/components/loading.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:bookario/components/rich_text_row.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../components/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<bool> isExpanded = new List();
  int limit, offset;
  List<dynamic> bookingData = [];
  var clubData;
  bool hasBookings = false,
      screenLoading = true,
      loadMore = false,
      loadingMore = false;
  List bookingDetails = [], moreBookingDetails = [];

  @override
  void initState() {
    offset = 0;
    limit = 10;
    getBookingData();
    super.initState();
  }

  getBookingData() async {
    String uid = await PersistenceHandler.getter('uid');
    try {
      var response = await Networking.getData('bookings/get-user-bookings', {
        "userId": uid,
        "limit": limit.toString(),
        "offset": offset.toString(),
      });
      print(response['data']);
      if (response['data'].length > 0) {
        setState(() {
          for (int i = 0; i < response['data'].length; i++) {
            isExpanded.add(false);
            bookingDetails.length = i + 1;
            bookingDetails[i] =
                json.decode(response['data'][i]['bookingDetails']);
          }
          hasBookings = true;
          loadMore = true;
          loadingMore = false;
          bookingData += response['data'];
        });
      } else {
        setState(() {
          screenLoading = false;
          loadMore = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(5)),
              hasBookings
                  ? Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ...List.generate(
                                bookingData.length,
                                (index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    child: Container(
                                      child: AnimatedCrossFade(
                                        crossFadeState: isExpanded[index]
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                        duration: Duration(milliseconds: 200),
                                        firstChild: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Stack(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12,
                                                          vertical: 5),
                                                      color: Color(0xFFd6d6d6)
                                                          .withOpacity(0.8),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          RichText(
                                                            text: bookingDetails[
                                                                            index][0]
                                                                        [
                                                                        'passCategory'] !=
                                                                    'Couples'
                                                                ? TextSpan(
                                                                    text: 'Booked by: ' +
                                                                        bookingData[index]
                                                                            [
                                                                            'name'],
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline6
                                                                        .copyWith(
                                                                          fontSize:
                                                                              getProportionateScreenWidth(17),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                  )
                                                                : TextSpan(
                                                                    text: 'Booked by: ' +
                                                                        bookingDetails[index][0]
                                                                            [
                                                                            'maleName'],
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline6
                                                                        .copyWith(
                                                                          fontSize:
                                                                              getProportionateScreenWidth(17),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                  ),
                                                          ),
                                                          RichTextRow(
                                                            textLeft:
                                                                "Booked on:  ",
                                                            textRight:
                                                                bookingData[
                                                                        index]
                                                                    ['date'],
                                                          ),
                                                          RichTextRow(
                                                            textLeft: "Paid:  ",
                                                            textRight: bookingData[
                                                                        index][
                                                                    'bookingAmount']
                                                                .toString(),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isExpanded[index]
                                                          ? isExpanded[index] =
                                                              false
                                                          : isExpanded[index] =
                                                              true;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5.0),
                                                    child: Icon(
                                                      isExpanded[index]
                                                          ? Icons.arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      size: 30,
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        secondChild: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Stack(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12,
                                                          vertical: 5),
                                                      color: Color(0xFFd6d6d6)
                                                          .withOpacity(0.8),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ...List.generate(
                                                              bookingDetails[
                                                                      index]
                                                                  .length, (j) {
                                                            return Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          8),
                                                              child: Column(
                                                                children: [
                                                                  bookingDetails[index][j]
                                                                              [
                                                                              'passCategory'] !=
                                                                          'Couples'
                                                                      ? Row(
                                                                          children: [
                                                                            Text(
                                                                              bookingDetails[index][j]['name'],
                                                                              style: Theme.of(context).textTheme.headline6.copyWith(
                                                                                    fontSize: getProportionateScreenWidth(16),
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              ', ' + bookingDetails[index][j]['gender'],
                                                                              style: Theme.of(context).textTheme.headline6.copyWith(
                                                                                    fontSize: getProportionateScreenWidth(13),
                                                                                    color: Colors.black,
                                                                                  ),
                                                                            ),
                                                                            Text(
                                                                              ', ' + bookingDetails[index][j]['age'],
                                                                              style: Theme.of(context).textTheme.headline6.copyWith(
                                                                                    fontSize: getProportionateScreenWidth(13),
                                                                                    color: Colors.black,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  bookingDetails[index][j]['maleName'],
                                                                                  style: Theme.of(context).textTheme.headline6.copyWith(
                                                                                        fontSize: getProportionateScreenWidth(16),
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  ', ' + bookingDetails[index][j]['maleGender'],
                                                                                  style: Theme.of(context).textTheme.headline6.copyWith(
                                                                                        fontSize: getProportionateScreenWidth(13),
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  ', ' + bookingDetails[index][j]['maleAge'],
                                                                                  style: Theme.of(context).textTheme.headline6.copyWith(
                                                                                        fontSize: getProportionateScreenWidth(13),
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  bookingDetails[index][j]['femaleName'],
                                                                                  style: Theme.of(context).textTheme.headline6.copyWith(
                                                                                        fontSize: getProportionateScreenWidth(16),
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  ', ' + bookingDetails[index][j]['femaleGender'],
                                                                                  style: Theme.of(context).textTheme.headline6.copyWith(
                                                                                        fontSize: getProportionateScreenWidth(13),
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                ),
                                                                                Text(
                                                                                  ', ' + bookingDetails[index][j]['femaleAge'],
                                                                                  style: Theme.of(context).textTheme.headline6.copyWith(
                                                                                        fontSize: getProportionateScreenWidth(13),
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        bookingDetails[index][j]
                                                                            [
                                                                            'passCategory'],
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline6
                                                                            .copyWith(
                                                                              fontSize: getProportionateScreenWidth(13),
                                                                              color: Colors.black,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        ', ' +
                                                                            bookingDetails[index][j]['passType'],
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline6
                                                                            .copyWith(
                                                                              fontSize: getProportionateScreenWidth(13),
                                                                              color: Colors.black,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                          SizedBox(height: 10),
                                                          RichTextRow(
                                                            textLeft:
                                                                "Booked on:  ",
                                                            textRight:
                                                                bookingData[
                                                                        index]
                                                                    ['date'],
                                                          ),
                                                          RichTextRow(
                                                            textLeft:
                                                                "Paid:  ₹",
                                                            textRight: bookingData[
                                                                        index][
                                                                    'bookingAmount']
                                                                .toString(),
                                                          ),
                                                          Container(
                                                            height: 200,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10),
                                                            width: SizeConfig
                                                                .screenWidth,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                QrImage(
                                                                  data: bookingData[
                                                                          index]
                                                                      [
                                                                      'passCode'],
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  errorStateBuilder:
                                                                      (cxt,
                                                                          err) {
                                                                    return Container(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "Uh oh! Something went wrong...",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isExpanded[index]
                                                          ? isExpanded[index] =
                                                              false
                                                          : isExpanded[index] =
                                                              true;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5.0),
                                                    child: Icon(
                                                      isExpanded[index]
                                                          ? Icons.arrow_drop_up
                                                          : Icons
                                                              .arrow_drop_down,
                                                      size: 30,
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(20)),
                            ],
                          ),
                        ),
                        loadMore
                            ? loadingMore
                                ? Loading()
                                : FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        offset += limit;
                                        loadingMore = true;
                                      });
                                      getBookingData();
                                    },
                                    child: Text(
                                      'load more',
                                    ),
                                    splashColor:
                                        Theme.of(context).primaryColorLight,
                                  )
                            : Container(),
                      ],
                    )
                  : screenLoading
                      ? Loading()
                      : Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Your bookings will be available here\nwhen you book an event.',
                            textAlign: TextAlign.center,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
