// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      primaryColor: Color(0xff0a0a0a),
      scaffoldBackgroundColor: Color(0xfffafafa),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff2294F2),
              textStyle: TextStyle(color: Color(0xffFFFFFF), fontSize: 14))));
}
