import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pyoneer/components/testing_component.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ChallengeQuestion {
  final String question;
  final List<String> choices;
  final String correctChoice;
  final String imageUrl;

  ChallengeQuestion({
    required this.question,
    required this.choices,
    required this.correctChoice,
    required this.imageUrl,
  });

  factory ChallengeQuestion.fromMap(Map<String, dynamic> map) {
    return ChallengeQuestion(
      question: map['question'],
      choices: List<String>.from(map['choice']),
      correctChoice: map['correctChoice'],
      imageUrl: map['imageUrl'],
    );
  }
}

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  late Timer _timer;
  List<ChallengeQuestion> _challengeQuestions = [];
  Map<String, String?> selectedChoices = {};
  bool _isLoading = true;
  bool _allQuestionsAnswered = false;
  int _score = 0;
  bool _isSubmitted = false;

  void _checkAllQuestionsAnswered() {
    setState(() {
      _allQuestionsAnswered =
          selectedChoices.length == _challengeQuestions.length;
    });
  }

  void _calculateScore() {
    _score = 0;
    for (var question in _challengeQuestions) {
      final selectedChoice = selectedChoices[question.question];
      if (selectedChoice == question.correctChoice) {
        _score++;
      }
    }
  }

  Future<void> _submitAnswers() async {
    _calculateScore();

    final uid = UserData.uid;
    final userName = UserData.userName;
    final email = UserData.email;
    final image = UserData.image;
    final time = _stopWatchTimer.rawTime.value;
    final timestamp = Timestamp.now();

    final challengeScoreRef =
        FirebaseFirestore.instance.collection('challengeScore').doc(email);

    final currentScoreSnapshot = await challengeScoreRef.get();
    final currentScore =
        currentScoreSnapshot.exists ? currentScoreSnapshot.data()!['score'] : 0;
    final currentTime = currentScoreSnapshot.exists
        ? currentScoreSnapshot.data()!['timeSpent']
        : double.infinity;

    if (_score > currentScore ||
        (_score == currentScore && time < currentTime)) {
      await challengeScoreRef.set({
        'UID': uid,
        'Name': userName,
        'photoUrl': image,
        'timeSpent': time,
        'timeStamp': timestamp,
        'score': _score,
      });

      setState(() {
        _isSubmitted = true;
      });

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: 'คุณทำได้ $_score คะแนน',
          backgroundColor: Colors.green,
        ),
        displayDuration: const Duration(seconds: 2),
      );

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      setState(() {
        _isSubmitted = true;
      });

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: 'คุณทำได้ $_score คะแนน',
          backgroundColor: Colors.green,
        ),
        displayDuration: const Duration(seconds: 2),
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer(
      const Duration(milliseconds: 1500),
      () {
        _stopWatchTimer.onStartTimer();
      },
    );
    _loadChallengeQuestions();
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopWatchTimer.dispose();
    super.dispose();
  }

  Future<void> _loadChallengeQuestions() async {
    await Future.delayed(const Duration(seconds: 1));

    final snapshot =
        await FirebaseFirestore.instance.collection('challengeQuestion').get();

    final allQuestions = snapshot.docs.map((doc) {
      final data = doc.data();
      final choices = List<String>.from(data['choice']);
      choices.shuffle();
      return ChallengeQuestion.fromMap({
        ...data,
        'choice': choices,
      });
    }).toList();

    final random = Random();
    final selectedQuestions = <ChallengeQuestion>[];

    final questionCount = min(30, allQuestions.length);

    while (selectedQuestions.length < questionCount) {
      final randomIndex = random.nextInt(allQuestions.length);
      final question = allQuestions[randomIndex];

      if (!selectedQuestions.contains(question)) {
        selectedQuestions.add(question);
      }
    }

    setState(() {
      _challengeQuestions = selectedQuestions;
      _isLoading = false;
    });
  }

  Future<bool> _confirmExit() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('ยืนยันการออก'),
            content: const Text(
                'คุณแน่ใจหรือไม่ว่าต้องการออก? ระบบจะไม่บันทึกคะแนนของคุณ และเวลายังคงนับต่อไป'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('ยกเลิก'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('ออก'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          title: Column(
            children: [
              const Text("Challenge"),
              const SizedBox(height: 10),
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime = StopWatchTimer.getDisplayTime(value!,
                      hours: true, milliSecond: true);
                  return Text(
                    displayTime,
                    style: const TextStyle(color: AppColor.primarSnakeColor),
                  );
                },
              ),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List.generate(_challengeQuestions.length, (i) {
                        var question = _challengeQuestions[i];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${i + 1}. ${question.question}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            question.imageUrl.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: TestingComponent.challengeImage(
                                        context, question.imageUrl),
                                  )
                                : const SizedBox.shrink(),
                            for (var choice in question.choices)
                              RadioListTile<String?>(
                                title: Text(choice),
                                value: choice,
                                groupValue: selectedChoices[question.question],
                                onChanged: (value) {
                                  setState(() {
                                    selectedChoices[question.question] = value;
                                    _checkAllQuestionsAnswered();
                                  });
                                },
                              ),
                            const SizedBox(height: 20),
                          ],
                        );
                      }),
                      ElevatedButton(
                        style: const ButtonStyle(
                          minimumSize: MaterialStatePropertyAll(
                            Size(double.infinity, 50),
                          ),
                        ),
                        onPressed: _allQuestionsAnswered && !_isSubmitted
                            ? _submitAnswers
                            : null,
                        child: Text(_allQuestionsAnswered
                            ? "ส่งคำตอบ"
                            : "ยังตอบคำถามไม่ครบ"),
                      ),
                      const SizedBox(height: 50)
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
