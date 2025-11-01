import 'package:flutter/material.dart';

class MainColor {
  static const int _primaryValue = 0xfffaafa8;
  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xfffff7f6),
      100: Color(0xfffee7e5),
      200: Color(0xfffdd7d4),
      300: Color(0xfffcc7c2),
      400: Color(0xfffbb7b1),
      500: Color(0xfffaafa8), // Primary color
      600: Color(0xffe19e97),
      700: Color(0xffaf7a76),
      800: Color(0xff7d5854),
      900: Color(0xff644643),
    },
  );

  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
        100: Color(0xFF6FC2FF),
        200: Color(_primaryAccentValue),
        400: Color(0xFF0997FF),
        700: Color(0xFF0089EE),
      });
  static const int _primaryAccentValue = 0xFF3CACFF;
}
