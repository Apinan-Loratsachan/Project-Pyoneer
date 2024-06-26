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
  Map<int, String?> selectedChoices = {};
  bool _hasAlreadyTested = false;
  int _userScore = 0;
  int _totalQuestions = 0;
  String testType = '';
  bool _isTestSubmitted = false;

  @override
  void initState() {
    super.initState();
    _checkTest();
    _shufflePropositionsAndChoices();
    _fetchUserChoices();
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

    if (userEmail == 'ไม่ได้เข้าสู่ระบบ') {
      return;
    }

    var doc = await FirebaseFirestore.instance
        .collection('userChoices')
        .doc(userEmail)
        .collection(testType)
        .doc(widget.testId.toString())
        .get();

    if (doc.exists) {
      Map<String, dynamic> fetchedData = doc.data() as Map<String, dynamic>;
      Map<int, String?> fetchedChoices = {};

      widget.testingContent.asMap().forEach((index, testingContent) {
        String proposition = testingContent.proposition;
        String? selectedChoice = fetchedData[proposition];
        fetchedChoices[index] = selectedChoice;
      });

      setState(() {
        selectedChoices = fetchedChoices;
      });
    }
  }

  void _shufflePropositionsAndChoices() {
    final random = Random();
    widget.testingContent.shuffle(random);
    for (var testingContent in widget.testingContent) {
      testingContent.choice.shuffle(random);
    }
  }

  Future<void> _checkUserTestStatus() async {
    if (!widget.isPreTest) {
      setState(() {
        _hasAlreadyTested = false;
      });
      return;
    }

    bool alreadyTested = await ContentCounter.checkAlreadyTesting(
        UserData.email, int.parse(widget.testId.toString()), testType);
    setState(() {
      _hasAlreadyTested = alreadyTested;
    });
  }

  Future<void> _fetchTestResults() async {
    String userEmail = UserData.email;

    if (userEmail == 'ไม่ได้เข้าสู่ระบบ') {
      return;
    }

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

    if (userEmail == 'ไม่ได้เข้าสู่ระบบ') {
      return;
    }

    await FirebaseFirestore.instance
        .collection('userChoices')
        .doc(userEmail)
        .collection(testType)
        .doc(widget.testId.toString())
        .set({proposition: choice}, SetOptions(merge: true));
  }

  bool _allAnswersSelected() {
    return selectedChoices.length == widget.testingContent.length &&
        selectedChoices.values.every((value) => value != null);
  }

  int _countCorrectAnswers() {
    int correctCount = 0;
    for (int i = 0; i < widget.testingContent.length; i++) {
      if (selectedChoices[i] == widget.testingContent[i].correctChoice) {
        correctCount++;
      }
    }
    return correctCount;
  }

  Future<bool> _onWillPop() async {
    if (UserData.email == 'ไม่ได้เข้าสู่ระบบ' || !widget.isPreTest) {
      return Future.value(true);
    } else if (_hasAlreadyTested) {
      return Future.value(true);
    } else {
      return await TestingComponent.testingBackAlert(context);
    }
  }

  Future<void> _submitTestResults(int correctAnswers) async {
    String userEmail = UserData.email;
    int totalQuestions = widget.testingContent.length;

    if (userEmail == 'ไม่ได้เข้าสู่ระบบ') {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "กรุณาเข้าสู่ระบบก่อนทำแบบทดสอบ",
        ),
        displayDuration: const Duration(seconds: 3),
      );
      return;
    }

    setState(() {
      _isTestSubmitted = true;
    });

    if (!widget.isPreTest) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('testResult')
          .doc(userEmail)
          .collection(testType)
          .where('lessonTest', isEqualTo: widget.testId)
          .get();

      int attemptCount = snapshot.size + 1;

      if (attemptCount > 5) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: "คุณทำแบบทดสอบครบ 5 ครั้งแล้ว",
          ),
          displayDuration: const Duration(seconds: 3),
        );
        return;
      }

      Map<String, dynamic> testData = {
        'email': userEmail,
        'lessonTest': widget.testId,
        'testType': testType,
        'score': correctAnswers,
        'totalScore': totalQuestions,
        'attemptCount': attemptCount,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('testResult')
          .doc(userEmail)
          .collection(testType)
          .doc('lessonTest${widget.testId}_attempt$attemptCount')
          .set(testData);
    } else {
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
    }

    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: "คุณตอบถูก $correctAnswers จาก $totalQuestions คะแนน",
      ),
      displayDuration: const Duration(seconds: 3),
    );
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ElevatedButton submitButton = ElevatedButton(
      onPressed:
          (!widget.isPreTest || (widget.isPreTest && !_hasAlreadyTested)) &&
                  _allAnswersSelected()
              ? () async {
                  int correctAnswers = _countCorrectAnswers();
                  await _submitTestResults(correctAnswers);
                }
              : (!widget.isPreTest || (widget.isPreTest && !_hasAlreadyTested))
                  ? () {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message: "กรุณาตอบคำถามให้ครบทุกข้อ",
                        ),
                        displayDuration: const Duration(seconds: 2),
                      );
                    }
                  : null,
      style: ButtonStyle(
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        backgroundColor: MaterialStateColor.resolveWith(
            (states) => AppColor.primarSnakeColor.withAlpha(200)),
        overlayColor: MaterialStateColor.resolveWith(
            (states) => AppColor.secondarySnakeColor.withAlpha(255)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ส่งคำตอบ"),
        ],
      ),
    );

    // ignore: deprecated_member_use
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
                          title: Text(
                            choice,
                            style: TextStyle(
                              color: (!_hasAlreadyTested && !_isTestSubmitted)
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color
                                  : (!_isTestSubmitted)
                                      ? selectedChoices[i] == choice
                                          ? (choice == content.correctChoice
                                              ? Colors.green
                                              : Colors.red)
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .color,
                            ),
                          ),
                          value: choice,
                          groupValue: selectedChoices[i],
                          activeColor: (!_hasAlreadyTested && !_isTestSubmitted)
                              ? AppColor.secondarySnakeColor
                              : null,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                            if (!_hasAlreadyTested && !_isTestSubmitted) {
                              return AppColor.secondarySnakeColor;
                            } else if (!_isTestSubmitted &&
                                states.contains(MaterialState.selected)) {
                              return selectedChoices[i] == choice
                                  ? (choice == content.correctChoice
                                      ? Colors.green
                                      : Colors.red)
                                  : AppColor.secondarySnakeColor;
                            }
                            return Theme.of(context).disabledColor;
                          }),
                          secondary:
                              (!_hasAlreadyTested && !_isTestSubmitted) ||
                                      selectedChoices[i] != choice ||
                                      _isTestSubmitted
                                  ? null
                                  : Icon(
                                      choice == content.correctChoice
                                          ? Icons.check
                                          : Icons.close,
                                      color: (!_isTestSubmitted)
                                          ? choice == content.correctChoice
                                              ? Colors.green
                                              : Colors.red
                                          : Theme.of(context).disabledColor,
                                    ),
                          onChanged: _hasAlreadyTested || _isTestSubmitted
                              ? null
                              : (value) async {
                                  setState(() {
                                    selectedChoices[i] = value;
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
                !_hasAlreadyTested || !widget.isPreTest
                    ? submitButton
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

class UserChoice {
  final String proposition;
  final String? selectedChoice;

  UserChoice({required this.proposition, this.selectedChoice});

  Map<String, dynamic> toMap() {
    return {
      'proposition': proposition,
      'selectedChoice': selectedChoice,
    };
  }

  factory UserChoice.fromMap(Map<String, dynamic> map) {
    return UserChoice(
      proposition: map['proposition'],
      selectedChoice: map['selectedChoice'],
    );
  }
}
