import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color.theme.dart';
import 'layout.theme.dart';

final lightSystemTheme = SystemUiOverlayStyle.light.copyWith(
  statusBarIconBrightness: Brightness.light,
  statusBarColor: primaryColor,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.white,
);

final ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  iconTheme: IconThemeData(
    color: iconColor,
    size: 24,
  ),
  primarySwatch: Colors.red,
  textTheme: TextTheme(
    headline3: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: primaryColor),
    headline4: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: primaryColor),
    headline5: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: primaryColor),
    headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: primaryColor),
    bodyText1: TextStyle(fontSize: 16, color: Colors.black),
    bodyText2: TextStyle(fontSize: 12, color: Colors.black),
  ),
);

final InputDecoration inputDecoration = InputDecoration(
  filled: true,
  fillColor: const Color(0xFFEFF2F4),
  contentPadding: EdgeInsets.symmetric(horizontal: gutter),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
);
