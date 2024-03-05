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

class TestingScreenModel extends StatefulWidget {
  final List<TestingContent> testingContent;
  final String appBarTitle;
  final String appBarSubTitle;
  final bool isPreTest;
  final int testId;

  const TestingScreenModel({
    super.key,
    required this.testingContent,
    required this.appBarTitle,
    required this.appBarSubTitle,
    required this.isPreTest,
    required this.testId,
  });

  @override
  State<TestingScreenModel> createState() => _TestingScreenModelState();
}

class _TestingScreenModelState extends State<TestingScreenModel> {
  Map<String, String?> selectedChoices = {};
  bool _hasAlreadyTested = false;
  int _userScore = 0;
  int _totalQuestions = 0;
  String testType = '';

  @override
  void initState() {
    super.initState();
    _checkTest();
    _fetchUserChoices();
    _shufflePropositionsAndChoices();
    _checkUserTestStatus();
    _fetchTestResults();
  }

  void _checkTest() async {
    if (widget.isPreTest) {
      testType = 'pre-test';
    } else {
      testType = 'post-test';
    }
  }

  void _fetchUserChoices() async {
    String userEmail = UserData.email;

    var doc = await FirebaseFirestore.instance
        .collection('userChoices')
        .doc(userEmail)
        .collection(testType)
        .doc(widget.testId.toString())
        .get();

    if (doc.exists) {
      Map<String, String?> fetchedChoices =
          Map<String, String?>.from(doc.data() as Map);
      setState(() {
        selectedChoices = fetchedChoices;
      });
    }
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

  void _checkUserTestStatus() async {
    bool alreadyTested = await ContentCounter.checkAlreadyTesting(
        UserData.email, int.parse(widget.testId.toString()), testType);
    setState(() {
      _hasAlreadyTested = alreadyTested;
    });
  }

  Future<void> _fetchTestResults() async {
    String userEmail = UserData.email;

    var doc = await FirebaseFirestore.instance
        .collection('testResult')
        .doc(userEmail)
        .collection(testType)
        .doc('lessonTest ${widget.testId}')
        .get();

    if (doc.exists) {
      setState(() {
        _userScore = doc.data()?['score'] ?? 0;
        _totalQuestions = doc.data()?['totalScore'] ?? 0;
      });
    }
  }

  Future<void> saveUserChoice(String proposition, String? choice) async {
    String userEmail = UserData.email;

    await FirebaseFirestore.instance
        .collection('userChoices')
        .doc(userEmail)
        .collection(testType)
        .doc(widget.testId.toString())
        .set({proposition: choice}, SetOptions(merge: true));
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

  Future<bool> _onWillPop() async {
    if (_hasAlreadyTested) {
      return Future(() => true);
    } else {
      return await TestingComponent.testingBackAlert(context);
    }
  }

  Future<void> _submitTestResults(int correctAnswers) async {
    String userEmail = UserData.email;
    int totalQuestions = widget.testingContent.length;

    Map<String, dynamic> testData = {
      'email': userEmail,
      'lessonTest': widget.testId,
      'testType': testType,
      'score': correctAnswers,
      'totalScore': totalQuestions,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection('testResult')
        .doc(userEmail)
        .collection(testType)
        .doc('lessonTest ${widget.testId}')
        .set(testData);

    showTopSnackBar(
      // ignore: use_build_context_synchronously
      Overlay.of(context),
      CustomSnackBar.success(
        message: "คุณตอบถูก $correctAnswers จาก $totalQuestions คะแนน",
      ),
      displayDuration: const Duration(seconds: 3),
    );

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: TestingComponent.testingAppbar(
            widget.appBarTitle, widget.appBarSubTitle, context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _hasAlreadyTested
                    ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          'คุณได้ $_userScore จาก $_totalQuestions คะแนน',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColor.primarSnakeColor,
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 20),
                ...List.generate(widget.testingContent.length, (i) {
                  var content = widget.testingContent[i];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${i + 1}. ${content.proposition}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      content.imagePath.isNotEmpty
                          ? LessonComponent.lessonImage(
                              context,
                              content.imagePath,
                            )
                          : const SizedBox.shrink(),
                      for (var choice in content.choice)
                        RadioListTile<String?>(
                          title: Text(choice),
                          value: choice,
                          groupValue: selectedChoices[content.proposition],
                          activeColor: AppColor.secondarySnakeColor,
                          onChanged: _hasAlreadyTested
                              ? null
                              : (value) async {
                                  setState(() {
                                    selectedChoices[content.proposition] =
                                        value;
                                  });
                                  await saveUserChoice(
                                      content.proposition, value);
                                },
                        ),
                      const SizedBox(height: 20),
                    ],
                  )
                      .animate(
                        delay: 100.ms * i,
                      )
                      .fadeIn(
                        duration: 300.ms,
                      )
                      .slide(
                        begin: const Offset(0, 0.2),
                        duration: 300.ms,
                      );
                }),
                !_hasAlreadyTested
                    ? ElevatedButton(
                        onPressed: _allAnswersSelected()
                            ? () async {
                                int correctAnswers = _countCorrectAnswers();
                                await _submitTestResults(correctAnswers);
                              }
                            : () {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message: "กรุณาตอบคำถามให้ครบทุกข้อ",
                                  ),
                                  displayDuration: const Duration(seconds: 2),
                                );
                              },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  AppColor.primarSnakeColor.withAlpha(200)),
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  AppColor.secondarySnakeColor.withAlpha(255)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("ส่งคำตอบ"),
                          ],
                        ),
                      )
                    : const ElevatedButton(
                        onPressed: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("คุณทำแบบทดสอบไปแล้ว"),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
