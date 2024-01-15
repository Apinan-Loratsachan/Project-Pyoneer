import 'dart:async';
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final int typingSpeed; // milliseconds for each character
  final int cursorSpeed; // milliseconds for cursor blink

  const TypewriterText({
    Key? key,
    required this.text,
    this.textStyle,
    this.typingSpeed = 85,
    this.cursorSpeed = 500,
  }) : super(key: key);

  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String displayedText = "";
  String cursor = '|';
  int textIndex = 0;
  Timer? typingTimer;
  Timer? cursorTimer;
  bool showCursor = true;

  @override
  void initState() {
    super.initState();
    typingTimer =
        Timer.periodic(Duration(milliseconds: widget.typingSpeed), (timer) {
      if (textIndex < widget.text.length) {
        setState(() {
          displayedText += widget.text[textIndex];
          textIndex++;
        });
      } else {
        timer.cancel();
      }
    });

    cursorTimer =
        Timer.periodic(Duration(milliseconds: widget.cursorSpeed), (timer) {
      if (textIndex < widget.text.length) {
        setState(() {
          showCursor = !showCursor;
        });
      } else if (showCursor) {
        setState(() {
          showCursor = false;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    typingTimer?.cancel();
    cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      displayedText + (showCursor ? cursor : ''),
      style: widget.textStyle,
    );
  }
}
