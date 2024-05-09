import 'package:flutter/material.dart';
import 'package:pyoneer/components/testing_component.dart';
import 'package:pyoneer/models/testing_model.dart';

class Testing1Screen extends StatefulWidget {
  final bool isPreTest;
  const Testing1Screen({super.key, required this.isPreTest});

  @override
  State<Testing1Screen> createState() => _Testing1ScreenState();
}

class _Testing1ScreenState extends State<Testing1Screen> {
  @override
  Widget build(BuildContext context) {
    return TestingScreenModel(
      testingContent: Testing1.testingContent,
      appBarTitle: "บทที่ 1",
      appBarSubTitle: widget.isPreTest
          ? "แบบทดสอบก่อนเรียนบทที่ 1"
          : "แบบทดสอบหลังเรียนบทที่ 1",
      isPreTest: widget.isPreTest,
      testId: 1,
    );
  }
}
