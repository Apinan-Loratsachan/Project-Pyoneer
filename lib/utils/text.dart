import 'package:flutter/material.dart';

class PyoneerText {
  static const double titleTextSize = 40;
  static const double bodyTextSize = 20;
  static const double textSpaceSize = 25;
  static const String startParagraph = "\n\t\t\t\t\t\t\t\t\t\t\t";

  static Text bodyText(String text, [double fontSize = bodyTextSize, FontWeight fontWeight = FontWeight.normal]) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
