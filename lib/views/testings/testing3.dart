import 'package:flutter/material.dart';
import 'package:pyoneer/components/testing_component.dart';
import 'package:pyoneer/models/testing_model.dart';

class Testing3Screen extends StatefulWidget {
  final bool isPreTest;
  const Testing3Screen({super.key, required this.isPreTest});

  @override
  State<Testing3Screen> createState() => _Testing3ScreenState();
}

class _Testing3ScreenState extends State<Testing3Screen> {
  @override
  Widget build(BuildContext context) {
    return TestingScreenModel(
      testingContent: Testing3.testingContent,
      appBarTitle: "บทที่ 3",
      appBarSubTitle: widget.isPreTest
          ? "แบบทดสอบก่อนเรียนบทที่ 3"
          : "แบบทดสอบหลังเรียนบทที่ 3",
      isPreTest: widget.isPreTest,
      testId: 3,
    );
  }
}
