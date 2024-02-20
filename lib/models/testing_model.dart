import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pyoneer/components/testing_component.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TestingScreenModel extends StatefulWidget {
  final int lessonTest;
  final bool isPreTest;
  final List<TestingContent> testingContent;

  const TestingScreenModel({
    super.key,
    required this.lessonTest,
    required this.isPreTest,
    required this.testingContent,
  });

  @override
  State<TestingScreenModel> createState() => _Testing1ScreenState();
}

class _Testing1ScreenState extends State<TestingScreenModel> {
  Map<String, String?> selectedChoices = {}; // Map to store selected choices

  @override
  void initState() {
    super.initState();
    _shufflePropositionsAndChoices();
  }

  void _shufflePropositionsAndChoices() {
    final random = Random();

    // Shuffle propositions
    widget.testingContent.shuffle(random);

    // Shuffle choices for each proposition
    for (var testingContent in widget.testingContent) {
      testingContent.choice.shuffle(random);
    }
  }

  bool _allAnswersSelected() {
    return selectedChoices.length == widget.testingContent.length &&
        !selectedChoices.containsValue(null);
  }

  int _countCorrectAnswers() {
    int correctCount = 0;
    for (var content in widget.testingContent) {
      if (selectedChoices[content.proposition] == content.correctChoice) {
        correctCount++;
      }
    }
    return correctCount;
  }

  Future<bool> _onWillPop() {
    return TestingComponent.testingBackAlert(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: TestingComponent.testingAppbar(
            "ทดสอบก่อนเรียน", "บทที่ 1 คุณลักษณะของภาษาไพทอน", context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display shuffled propositions and choices as radio buttons
                for (var i = 0; i < widget.testingContent.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${i + 1}. ${widget.testingContent[i].proposition}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      // Display shuffled choices as radio buttons
                      for (var choice in widget.testingContent[i].choice)
                        RadioListTile<String?>(
                          title: Text(choice),
                          value: choice,
                          groupValue: selectedChoices[
                              widget.testingContent[i].proposition],
                          selectedTileColor: AppColor.primarSnakeColor,
                          activeColor: AppColor.secondarySnakeColor,
                          shape: ShapeBorder.lerp(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            0.5,
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedChoices[
                                  widget.testingContent[i].proposition] = value;
                            });
                          },
                        ),
                      const SizedBox(height: 50),
                    ],
                  )
                      .animate(
                        delay: 600.ms * i,
                      )
                      .fadeIn(
                        duration: 500.ms,
                      )
                      .slide(
                        begin: const Offset(0, 0.2),
                        duration: 500.ms,
                      ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_allAnswersSelected()) {
                          int correctAnswers = _countCorrectAnswers();
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message:
                                  "คุณตอบถูก $correctAnswers ข้อจาก ${widget.testingContent.length} ข้อ",
                            ),
                            displayDuration: const Duration(seconds: 2),
                          );
                          //email, lessonTest, testType, score, totalScore, timestamp
                          Map<String, dynamic> toMap() {
                            if (widget.isPreTest) {
                              return {
                                'email': UserData.email,
                                'lessonTest': widget.lessonTest,
                                'testType': "preTest",
                                'score': correctAnswers,
                                'totalScore': widget.testingContent.length,
                                'timestamp': FieldValue.serverTimestamp(),
                              };
                            } else {
                              return {
                                'email': UserData.email,
                                'lessonTest': widget.lessonTest,
                                'testType': "postTest",
                                'score': correctAnswers,
                                'totalScore': widget.testingContent.length,
                                'timestamp': FieldValue.serverTimestamp(),
                              };
                            }
                          }

                          FirebaseFirestore.instance
                              .collection('testResult')
                              .add(toMap());
                          Navigator.pop(context);
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message: "กรุณาตอบคำถามให้ครบทุกข้อ",
                            ),
                            displayDuration: const Duration(seconds: 2),
                          );
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) =>
                                AppColor.primarSnakeColor.withAlpha(200)),
                        overlayColor: MaterialStateColor.resolveWith((states) =>
                            AppColor.secondarySnakeColor.withAlpha(255)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.done),
                          SizedBox(width: 10),
                          Text("ส่งคำตอบ"),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
