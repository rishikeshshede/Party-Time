import 'package:bookario/components/bottom_navbar.dart';
import 'package:bookario/screens/details/details_screen.dart';
import 'package:bookario/screens/forgot_password/forgot_password_screen.dart';
import 'package:bookario/screens/history/booking_history.dart';
import 'package:bookario/screens/home/home_screen.dart';
import 'package:bookario/screens/login_success/login_success_screen.dart';
import 'package:bookario/screens/sign_in/sign_in_screen.dart';
import 'package:bookario/screens/sign_up/sign_up_screen.dart';
import 'package:bookario/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  BookingHistory.routeName: (context) => BookingHistory(),
  BottomCustomNavBar.routeName: (context) => BottomCustomNavBar()
};
