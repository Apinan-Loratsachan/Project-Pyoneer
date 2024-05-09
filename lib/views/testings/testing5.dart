import 'package:flutter/material.dart';
import 'package:pyoneer/components/testing_component.dart';
import 'package:pyoneer/models/testing_model.dart';

class Testing5Screen extends StatefulWidget {
  final bool isPreTest;

  const Testing5Screen({super.key, required this.isPreTest});

  @override
  State<Testing5Screen> createState() => _Testing5ScreenState();
}

class _Testing5ScreenState extends State<Testing5Screen> {
  @override
  Widget build(BuildContext context) {
    return TestingScreenModel(
      testingContent: Testing5.testingContent,
      appBarTitle: "บทที่ 5",
      appBarSubTitle: widget.isPreTest
          ? "แบบทดสอบก่อนเรียนบทที่ 5"
          : "แบบทดสอบหลังเรียนบทที่ 5",
      isPreTest: widget.isPreTest,
      testId: 5,
    );
  }
}
