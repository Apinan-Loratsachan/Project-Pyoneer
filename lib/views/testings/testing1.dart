import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/components/testing_component.dart';
import 'package:pyoneer/services/content_counter.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Testing1Screen extends StatefulWidget {
  const Testing1Screen({super.key});

  @override
  State<Testing1Screen> createState() => _Testing1ScreenState();
}

class _Testing1ScreenState extends State<Testing1Screen> {
  Map<String, String?> selectedChoices = {}; // Map to store selected choices

  final _testingContent = Testing1.testingContent;
  late bool checkAlreadyTesting;
  bool _hasAlreadyTested = false;
  int _userScore = 0;
  int _totalQuestions = 0;

  Future<void> _fetchTestResults() async {
    String userEmail = UserData.email;
    String testId = "1";

    var doc = await FirebaseFirestore.instance
        .collection('testResult')
        .doc(userEmail)
        .collection('pre-test')
        .doc('lessonTest $testId')
        .get();

    if (doc.exists) {
      setState(() {
        _userScore = doc.data()?['score'] ?? 0;
        _totalQuestions = doc.data()?['totalScore'] ?? 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserChoices();
    _shufflePropositionsAndChoices();
    _checkUserTestStatus();
    _fetchTestResults();
  }

  void _checkUserTestStatus() async {
    bool alreadyTested = await ContentCounter.checkAlreadyTesting(
        UserData.email, 01, "pre-test");
    setState(() {
      _hasAlreadyTested = alreadyTested;
    });
  }

  Future<void> _fetchUserChoices() async {
    String testId = "01";
    String userEmail = UserData.email;

    var doc = await FirebaseFirestore.instance
        .collection('userChoices')
        .doc(userEmail)
        .collection('pre-test')
        .doc(testId)
        .get();

    if (doc.exists) {
      Map<String, String?> fetchedChoices =
          Map<String, String?>.from(doc.data() as Map);
      setState(() {
        selectedChoices = fetchedChoices;
      });
    }
  }

  Future<void> saveUserChoice(String proposition, String? choice) async {
    String testId = "01";
    String userEmail = UserData.email;

    await FirebaseFirestore.instance
        .collection('userChoices')
        .doc(userEmail)
        .collection('pre-test')
        .doc(testId)
        .set({proposition: choice}, SetOptions(merge: true));
  }

  void _shufflePropositionsAndChoices() {
    final random = Random();

    // Shuffle propositions
    _testingContent.shuffle(random);

    // Shuffle choices for each proposition
    for (var testingContent in _testingContent) {
      testingContent.choice.shuffle(random);
    }
  }

  bool _allAnswersSelected() {
    return selectedChoices.length == _testingContent.length &&
        !selectedChoices.containsValue(null);
  }

  int _countCorrectAnswers() {
    int correctCount = 0;
    for (var content in _testingContent) {
      if (selectedChoices[content.proposition] == content.correctChoice) {
        correctCount++;
      }
    }
    return correctCount;
  }

  Future<bool> _onWillPop() async {
    if (_hasAlreadyTested) {
      return Future(() => true);
    } else {
      return TestingComponent.testingBackAlert(context);
    }
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
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'คุณได้ $_userScore จาก $_totalQuestions คะแนน',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColor.primarSnakeColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Display shuffled propositions and choices as radio buttons
                for (var i = 0; i < _testingContent.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${i + 1}. ${_testingContent[i].proposition}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      _testingContent[i].imagePath.isNotEmpty
                          ? LessonComponent.lessonImage(
                              context,
                              _testingContent[i].imagePath,
                            )
                          : const SizedBox.shrink(),
                      // Display shuffled choices as radio buttons
                      for (var choice in _testingContent[i].choice)
                        RadioListTile<String?>(
                          title: Text(choice),
                          value: choice,
                          groupValue:
                              selectedChoices[_testingContent[i].proposition],
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
                          onChanged: _hasAlreadyTested
                              ? null
                              : (value) async {
                                  setState(() {
                                    selectedChoices[
                                        _testingContent[i].proposition] = value;
                                  });
                                  await saveUserChoice(
                                      _testingContent[i].proposition, value);
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
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: FutureBuilder<bool>(
                          future: ContentCounter.checkAlreadyTesting(
                              UserData.email, 1, "pre-test"),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            return snapshot.data ?? false
                                ? const ElevatedButton(
                                    onPressed: null,
                                    child: Text(
                                      "คุณทำแบบทดสอบนี้ไปแล้ว",
                                      style: TextStyle(
                                        color: AppColor.primarSnakeColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      if (_allAnswersSelected()) {
                                        bool checkAlreadyTesting =
                                            await ContentCounter
                                                .checkAlreadyTesting(
                                                    UserData.email,
                                                    1,
                                                    "pre-test");
                                        if (checkAlreadyTesting) {
                                          showTopSnackBar(
                                            // ignore: use_build_context_synchronously
                                            Overlay.of(context),
                                            const CustomSnackBar.info(
                                              message: "คุณทำการทดสอบนี้ไปแล้ว",
                                            ),
                                            displayDuration:
                                                const Duration(seconds: 2),
                                          );
                                        } else {
                                          int correctAnswers =
                                              _countCorrectAnswers();
                                          // await _submitTestResults(correctAnswers);
                                          showTopSnackBar(
                                            // ignore: use_build_context_synchronously
                                            Overlay.of(context),
                                            CustomSnackBar.success(
                                              message:
                                                  "คุณตอบถูก $correctAnswers ข้อจาก ${_testingContent.length} ข้อ",
                                            ),
                                            displayDuration:
                                                const Duration(seconds: 2),
                                          );
                                          //email, lessonTest, testType, score, totalScore, timestamp
                                          Map<String, dynamic> toMap() {
                                            return {
                                              'email': UserData.email,
                                              'lessonTest': 1,
                                              'testType': "pre-test",
                                              'score': correctAnswers,
                                              'totalScore':
                                                  _testingContent.length,
                                              'timestamp':
                                                  FieldValue.serverTimestamp(),
                                            };
                                          }

                                          FirebaseFirestore.instance
                                              .collection('testResult')
                                              .doc(UserData.email)
                                              .collection('pre-test')
                                              .doc("lessonTest 1")
                                              .set(toMap());

                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          const CustomSnackBar.error(
                                            message:
                                                "กรุณาตอบคำถามให้ครบทุกข้อ",
                                          ),
                                          displayDuration:
                                              const Duration(seconds: 2),
                                        );
                                      }
                                    },
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.white),
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => AppColor
                                                  .primarSnakeColor
                                                  .withAlpha(200)),
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => AppColor
                                                  .secondarySnakeColor
                                                  .withAlpha(255)),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.done),
                                        SizedBox(width: 10),
                                        Text("ส่งคำตอบ"),
                                      ],
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
