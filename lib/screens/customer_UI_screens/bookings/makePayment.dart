import 'package:bookario/components/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MakePayment extends StatefulWidget {
  final int totalAmount;
  final event;
  const MakePayment({Key key, this.totalAmount, this.event}) : super(key: key);

  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  Razorpay razorpay;
  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('payment successful');
    // TODO: send 'await' data to server
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomCustomNavBar(),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('payment error');
    Navigator.pop(
        context, false); // TODO: show scackbar to user that payment failed
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('payment wallet');
    Navigator.pop(context, true); // TODO: check it's need
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Make Payment')),
      body: Container(),
    );
  }
}
