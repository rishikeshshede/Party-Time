import 'dart:convert';

import 'package:bookario/components/bottom_navbar.dart';
import 'package:bookario/components/networking.dart';
import 'package:bookario/components/persistence_handler.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MakePayment extends StatefulWidget {
  final int totalAmount, maleCount, femaleCount, couplesCount;
  final event, bookings;
  const MakePayment(
      {Key key,
      this.totalAmount,
      this.event,
      this.bookings,
      this.maleCount,
      this.femaleCount,
      this.couplesCount})
      : super(key: key);

  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  Razorpay razorpay;
  String uid, date;

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getUid();
    openCheckOut();
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckOut() {
    var options = {
      "key": "rzp_test_lJ3WooT48LoqJY",
      "amount": widget.totalAmount * 100,
      "name": widget.event['name'],
      "description": "Make payment to book your tickets",
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void getUid() async {
    String userId = await PersistenceHandler.getter('uid');
    print('uid is: $userId');
    DateTime now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day).toString();
    setState(() {
      uid = userId;
      date = date.replaceAll('-', '/').substring(0, 10);
    });
    print('date: $date');
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print('payment successful');
    try {
      var response = await Networking.post('bookings/add-booking', {
        'name': widget.bookings[0]['name'],
        'userId': uid,
        'clubId': widget.event['clubId'].toString(),
        'eventId': widget.event['eventId'].toString(),
        'bookingDetails': jsonEncode(widget.bookings),
        'amountPaid': widget.totalAmount.toString(),
        'bookingDate': date,
        'maleCount': widget.maleCount.toString(),
        'femaleCount': widget.femaleCount.toString(),
        'coupleCount': widget.couplesCount.toString(),
      });
      if (response['success']) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomCustomNavBar(),
          ),
        );
      } else {}
    } catch (e) {
      print(e);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('payment error');
    Navigator.pop(context, false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('payment wallet');
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Make Payment')),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Redirecting...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
