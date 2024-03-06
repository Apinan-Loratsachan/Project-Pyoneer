import 'package:flutter/material.dart';
import 'package:pyoneer/components/testing_component.dart';
import 'package:pyoneer/models/testing_model.dart';

class Testing4Screen extends StatefulWidget {
  final bool isPreTest;
  const Testing4Screen({super.key, required this.isPreTest});

  @override
  State<Testing4Screen> createState() => _Testing4ScreenState();
}

class _Testing4ScreenState extends State<Testing4Screen> {
  @override
  Widget build(BuildContext context) {
    return TestingScreenModel(
      testingContent: Testing4.testingContent,
      appBarTitle: "Testing 4",
      appBarSubTitle: "Testing 4 Subtitle",
      isPreTest: widget.isPreTest,
      testId: 4,
    );
  }
}