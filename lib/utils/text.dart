import 'package:flutter/material.dart';

class PyoneerText {
  static const double titleTextSize = 40;
  static const double bodyTextSize = 17;
  static const double brakeLineSize = 25;
  static const double spanLineSize = 5;
  static const String startParagraph = "\n\t\t\t\t\t";

  static Align contentText(String text,
      {double fontSize = bodyTextSize,
      FontWeight fontWeight = FontWeight.normal,
      TextAlign textAlign = TextAlign.left,
      bool tabSpace = false,
      Alignment boxAlign = Alignment.centerLeft,
      TextDecoration textDecoration = TextDecoration.none,
      bool textSpaceSpan = false,
      FontStyle fontStyle = FontStyle.normal}) {
    if (tabSpace) {
      text = "\t\t\t\t\t$text";
    }
    if (textSpaceSpan) {
      text = text.replaceAll(" ", "    ");
    }
    return Align(
      alignment: boxAlign,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: textDecoration,
        ),
        textAlign: textAlign,
      ),
    );
  }

  static SizedBox brakeLine([double height = brakeLineSize]) {
    return SizedBox(
      height: height,
    );
  }

  static SizedBox spanLine([double width = spanLineSize]) {
    return SizedBox(
      width: width,
    );
  }

  static Divider divider(double inDent) {
    return Divider(
      indent: inDent,
      endIndent: inDent,
    );
  }
}
