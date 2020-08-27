import 'package:flutter/material.dart';

ThemeData buildTheme() {
  return ThemeData(
    primaryColor: Color.fromRGBO(234, 84, 85, 1),
    accentColor: Color.fromRGBO(45, 64, 89, 1),
    splashColor: Color.fromRGBO(222, 205, 195, 1),
    textTheme: buildTextTheme(),
  );
}

TextTheme buildTextTheme() {
  return TextTheme(
    bodyText1: TextStyle(
      color: Color.fromRGBO(229, 229, 229, 1),
    ),
    bodyText2: TextStyle(
      color: Color.fromRGBO(229, 229, 229, 1),
    ),
  );
}
