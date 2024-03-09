import 'package:flutter/material.dart';
import 'package:pyoneer/components/testing_component.dart';
import 'package:pyoneer/models/testing_model.dart';

class Testing2Screen extends StatefulWidget {
  final bool isPreTest;
  const Testing2Screen({super.key, required this.isPreTest});

  @override
  State<Testing2Screen> createState() => _Testing2ScreenState();
}

class _Testing2ScreenState extends State<Testing2Screen> {
  @override
  Widget build(BuildContext context) {
    return TestingScreenModel(
      testingContent: Testing2.testingContent,
      appBarTitle: "Test 2",
      appBarSubTitle: widget.isPreTest
          ? "แบบทดสอบก่อนเรียนบทที่ 2"
          : "แบบทดสอบหลังเรียนบทที่ 2",
      isPreTest: widget.isPreTest,
      testId: 2,
    );
  }
}
