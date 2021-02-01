import 'package:flutter/material.dart';

import 'components/constants.dart';

ThemeData theme() {
  return ThemeData(
      primaryColor: Color(0xFF1E1D1D),
      scaffoldBackgroundColor: Color(0xFF000000),
      fontFamily: "Muli",
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      unselectedWidgetColor: Colors.white);
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 4,
  );
  return InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey[600]),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    labelStyle: TextStyle(color: kSecondaryColor),
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    color: Color(0xFF141414),
    elevation: 1,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white, fontSize: 22),
    ),
  );
}
