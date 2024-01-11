import 'package:flutter/material.dart';

class PyoneerText {
  static const double titleTextSize = 40;
  static const double bodyTextSize = 20;
  static const double brakeLineSize = 25;
  static const String startParagraph = "\n\t\t\t\t\t\t\t\t\t\t\t";

  static Text contentText(String text, {double fontSize = bodyTextSize, FontWeight fontWeight = FontWeight.normal, TextAlign textAlign = TextAlign.start, bool tabSpace = false}) {
    if (tabSpace) {
      text = startParagraph + text;
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

  static SizedBox brakeLine({double height = brakeLineSize}) {
    return SizedBox(
      height: height,
    );
  }
}
