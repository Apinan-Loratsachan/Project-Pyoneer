import 'package:flutter/material.dart';
import 'package:pyoneer/components/testing_component.dart';
import 'package:pyoneer/models/testing_model.dart';

class Testing2Screen extends StatefulWidget {
  const Testing2Screen({super.key});

  @override
  State<Testing2Screen> createState() => _Testing2ScreenState();
}

class _Testing2ScreenState extends State<Testing2Screen> {
  @override
  Widget build(BuildContext context) {
    return TestingScreenModel(
      testingContent: Testing2.testingContent,
      appBarTitle: "askjdkฟหกฟหากาฟหกาวฟาหวากฟหกฟหกกฟหกฟก",
      appBarSubTitle: "กด่เา่ดเาสกดเส่ดเ่กดเาสด่กเ่กดาสเา่กดาเ",
      isPreTest: true,
      testId: 2,
    );
  }
}
