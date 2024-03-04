import 'dart:async';
import 'package:flutter/material.dart';

class TypeWriterText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final int typingSpeed; // milliseconds for each character
  final int cursorSpeed; // milliseconds for cursor blink

  const TypeWriterText({
    super.key,
    required this.text,
    this.textStyle,
    this.typingSpeed = 85,
    this.cursorSpeed = 500,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TypeWriterTextState createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText> {
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
      overflow: TextOverflow.ellipsis,
    );
  }
}
