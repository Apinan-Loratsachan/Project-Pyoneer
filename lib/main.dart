import 'package:flutter/material.dart';
import 'package:pyoneer/views/content.dart';
import 'package:flutter/services.dart';
// import 'package:pyoneer/views/register.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Set status bar color to transparent
    statusBarIconBrightness: Brightness.dark, // Set status bar icon color
    systemNavigationBarColor: Colors.transparent, // Set navigation bar color
    systemNavigationBarIconBrightness:
        Brightness.dark, // Set navigation bar icon color
  ));

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Noto Sans Thai',
    ),
    debugShowCheckedModeBanner: false,
    home: const ContentScreen(),
  ));
}
