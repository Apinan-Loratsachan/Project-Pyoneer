import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/components/testing_component.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _scrollController = ScrollController();

  bool _isAtBottom = false;
  bool _showFab = true;
  Timer? _hideFabTimer;
  double spaceSize = 25;

  static const Map<int, String> thaiMonths = {
    1: 'ม.ค.',
    2: 'ก.พ.',
    3: 'มี.ค.',
    4: 'เม.ย.',
    5: 'พ.ค.',
    6: 'มิ.ย.',
    7: 'ก.ค.',
    8: 'ส.ค.',
    9: 'ก.ย.',
    10: 'ต.ค.',
    11: 'พ.ย.',
    12: 'ธ.ค.'
  };

  @override
  void initState() {
    super.initState();
    _startHideFabTimer();

    _scrollController.addListener(() {
      final atBottom = _scrollController.position.atEdge &&
          _scrollController.position.pixels != 0;
      if (atBottom != _isAtBottom) {
        setState(() => _isAtBottom = atBottom);
      }

      if (!_showFab) {
        setState(() => _showFab = true);
      }
      _startHideFabTimer();
    });
  }

  void _startHideFabTimer() {
    _hideFabTimer?.cancel();
    _hideFabTimer = Timer(const Duration(seconds: 1), () {
      setState(() => _showFab = false);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hideFabTimer?.cancel();
    super.dispose();
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  void _scrollUp() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Stream<Map<String, dynamic>> fetchTestScore(
      String email, String testType, int lessonIndex) {
    if (email == 'ไม่ได้เข้าสู่ระบบ') {
      return Stream.value(
          {'score': null, 'totalScore': null, 'testDate': null});
    }
    return FirebaseFirestore.instance
        .collection('testResult')
        .doc(email)
        .collection(testType)
        .doc('lessonTest $lessonIndex')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data()!;
      } else {
        return {'score': null, 'totalScore': null, 'testDate': null};
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String greetingWord = _getGreetingWord();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: IgnorePointer(
          ignoring: true,
          child: AppBar(
              title: Column(
                children: [
                  Text(
                    "$greetingWord ${UserData.userName}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: AppColor.primarSnakeColor.withOpacity(0.5),
                          offset: const Offset(0.0, 5.0),
                        ),
                      ],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "บทเรียน",
                    style: TextStyle(shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Theme.of(context).colorScheme.background,
                        offset: const Offset(0.0, 0.0),
                      ),
                    ]),
                  ),
                  // const SizedBox(height: 50),
                ],
              ),
              centerTitle: true,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              toolbarHeight: 100,
              elevation: 0,
              // backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.background,
                      Theme.of(context).colorScheme.background,
                      Theme.of(context).colorScheme.background,
                      Theme.of(context).colorScheme.background,
                      Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.75),
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                      Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.25),
                      Theme.of(context).colorScheme.background.withOpacity(0),
                    ],
                  ),
                ),
              )),
        ),
      ),
      // floatingActionButtonLocation: CustomFabLocation(),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButton: _showFab
      //     ? (_isAtBottom
      //         ? FloatingActionButton(
      //             backgroundColor:
      //                 AppColor.secondarySnakeColor.withOpacity(0.5),
      //             foregroundColor: Colors.black,
      //             onPressed: _scrollUp,
      //             child: const Icon(Icons.arrow_upward),
      //           )
      //         : FloatingActionButton(
      //             backgroundColor:
      //                 AppColor.secondarySnakeColor.withOpacity(0.5),
      //             foregroundColor: Colors.black,
      //             onPressed: _scrollDown,
      //             child: const Icon(Icons.arrow_downward),
      //           ))
      //     : null,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        // controller: _scrollController,
        child: Column(
          children: [
            // ElevatedButton(
            //     onPressed: () => Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const Testing2Screen())),
            //     child: const Text('Test')),
            const SizedBox(height: 120),
            Column(
              children: [
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.07,
                  isFirst: true,
                  // isLast: true,
                  //isPast: true,
                  beforeLineStyle:
                      const LineStyle(color: AppColor.primarSnakeColor),
                  indicatorStyle: const IndicatorStyle(
                    width: 40,
                    color: AppColor.primarSnakeColor,
                    indicatorXY: 0.42,
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          elevation: 10,
                          shadowColor: AppColor.secondarySnakeColor,
                          color: AppColor.primarSnakeColor.withAlpha(255),
                          child: lessonTitle(
                            LessonComponent.lessonContent[0].imageSrc,
                            LessonComponent.lessonContent[0].heroTag,
                            LessonComponent.lessonContent[0].title,
                            LessonComponent.lessonContent[0].subTitle,
                            LessonComponent.lessonContent[0].targetScreen,
                            context,
                            0,
                            'Lesson',
                            Stream.value(true),
                          ),
                        ),
                        SizedBox(height: spaceSize),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    for (int i = 1;
                        i < LessonComponent.lessonContent.length;
                        i++)
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.07,
                        isLast: i == LessonComponent.lessonContent.length - 1
                            ? true
                            : false,
                        indicatorStyle: const IndicatorStyle(
                          width: 40,
                          color: AppColor.primarSnakeColor,
                          indicatorXY: 0.24,
                        ),
                        endChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: spaceSize,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "บทที่ $i",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              StreamBuilder<Map<String, dynamic>>(
                                stream: fetchTestScore(
                                    UserData.email, 'pre-test', i),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Map<String, dynamic>>
                                        snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Text("???");
                                  } else {
                                    int? score = snapshot.data?['score'];
                                    int? totalScore =
                                        snapshot.data?['totalScore'];
                                    Timestamp? timeStamp =
                                        snapshot.data?['timestamp'];
                                    DateTime? testDate = timeStamp?.toDate();
                                    String subtitle =
                                        "โปรดทำแบบทดสอบก่อนที่จะเริ่มเรียนบทนี้";
                                    Color lessonColor = Colors.grey;
                                    Color postTestColor = Colors.grey;
                                    if (score != null &&
                                        totalScore != null &&
                                        testDate != null) {
                                      String thaiMonth =
                                          thaiMonths[testDate.month] ?? '';
                                      int thaiYear = testDate.year + 543;
                                      subtitle =
                                          "$score/$totalScore คะแนน | ${testDate.day} $thaiMonth $thaiYear ${testDate.hour.toString().padLeft(2, '0')}:${testDate.minute.toString().padLeft(2, '0')} น.";
                                      lessonColor = AppColor.primarSnakeColor;
                                      postTestColor = Colors.white;
                                    }
                                    return Column(
                                      children: [
                                        Card(
                                          elevation: 10,
                                          child: lessonTitle(
                                            "assets/icons/pre_test.png",
                                            "pre_test_$i",
                                            "แบบทดสอบก่อนเรียนบทที่ $i",
                                            subtitle,
                                            TestingScreen.preTest[i - 1],
                                            context,
                                            i,
                                            'Pre-test',
                                            Stream.value(true),
                                          ),
                                        ),
                                        Card(
                                          elevation: 10,
                                          shadowColor:
                                              AppColor.secondarySnakeColor,
                                          color: lessonColor,
                                          // surfaceTintColor: AppColor.secondarySnakeColor,
                                          child: lessonTitle(
                                            LessonComponent
                                                .lessonContent[i].imageSrc,
                                            LessonComponent
                                                .lessonContent[i].heroTag,
                                            LessonComponent
                                                .lessonContent[i].title,
                                            LessonComponent
                                                .lessonContent[i].subTitle,
                                            LessonComponent
                                                .lessonContent[i].targetScreen,
                                            context,
                                            i,
                                            'Lesson',
                                            fetchTestScore(UserData.email,
                                                    'pre-test', i)
                                                .map((data) =>
                                                    data['score'] != null),
                                          ),
                                        ),
                                        StreamBuilder<Map<String, dynamic>>(
                                          stream: fetchTestScore(
                                              UserData.email, 'post-test', i),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<
                                                      Map<String, dynamic>>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return const Text("???");
                                            } else {
                                              int? score =
                                                  snapshot.data?['score'];
                                              int? totalScore =
                                                  snapshot.data?['totalScore'];
                                              Timestamp? timeStamp =
                                                  snapshot.data?['timestamp'];
                                              DateTime? testDate =
                                                  timeStamp?.toDate();
                                              String subtitle =
                                                  "ยังไม่ได้ทำแบบทดสอบ";
                                              if (score != null &&
                                                  totalScore != null &&
                                                  testDate != null) {
                                                String thaiMonth = thaiMonths[
                                                        testDate.month] ??
                                                    '';
                                                int thaiYear =
                                                    testDate.year + 543;
                                                subtitle =
                                                    "$score/$totalScore คะแนน | ${testDate.day} $thaiMonth $thaiYear ${testDate.hour.toString().padLeft(2, '0')}:${testDate.minute.toString().padLeft(2, '0')} น.";
                                              }
                                              return Card(
                                                color: postTestColor,
                                                elevation: 10,
                                                child: lessonTitle(
                                                  "assets/icons/post_test.png",
                                                  "post_test_$i",
                                                  "แบบทดสอบหลังเรียนบทที่ $i",
                                                  subtitle,
                                                  TestingScreen.postTest[i - 1],
                                                  context,
                                                  i,
                                                  'Post-test',
                                                  fetchTestScore(UserData.email,
                                                          'pre-test', i)
                                                      .map((data) =>
                                                          data['score'] !=
                                                          null),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: spaceSize),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 120),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  //-----------------------------------------------------------------------------------

  static Stream<bool> checkLessonReadStatus(String email, int lessonIndex) {
    if (email == 'ไม่ได้เข้าสู่ระบบ') {
      return Stream.value(false);
    }
    return FirebaseFirestore.instance
        .collection('lessons')
        .where('email', isEqualTo: email)
        .where('lessonRead', isEqualTo: lessonIndex)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.isNotEmpty);
  }

  Widget lessonTitle(
    String imageSrc,
    String heroTag,
    String title,
    String subtitle,
    Widget targetScreen,
    BuildContext context,
    int index,
    String type,
    Stream<bool> isUnlocked,
  ) {
    return StreamBuilder<bool>(
      stream: isUnlocked,
      builder: (context, snapshot) {
        bool unlocked = snapshot.data ?? false;
        return ListTile(
          leading: Hero(
            tag: heroTag,
            child: Image.asset(imageSrc, width: 50, height: 50),
          ),
          onTap: unlocked
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => targetScreen),
                  )
              : null,
          title: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: type == 'Lesson'
              ? StreamBuilder<bool>(
                  stream: _ContentScreenState.checkLessonReadStatus(
                      UserData.email, index),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    } else if (snapshot.data == true) {
                      return const Icon(Icons.check, color: Colors.black);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )
              : null, // Only show the check status for the main lesson
          // tileColor:
          //     !unlocked ? Theme.of(context).colorScheme.background : null,
          enabled: unlocked,
        );
      },
    );
  }
}

String _getGreetingWord() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  if (hour >= 4 && hour < 12) {
    return '🌤️ อรุณสวัสดิ์';
  } else if (hour >= 12 && hour < 16) {
    return '☀️ สวัสดียามบ่าย';
  } else if (hour >= 16 && hour < 19) {
    return '🌥️ สายัณห์สวัสดิ์';
  } else {
    return '🌙 สวัสดียามค่ำ';
  }
}

class CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = scaffoldGeometry.scaffoldSize.width -
        scaffoldGeometry.floatingActionButtonSize.width -
        16;
    final double fabY = scaffoldGeometry.scaffoldSize.height -
        scaffoldGeometry.floatingActionButtonSize.height -
        120;
    return Offset(fabX, fabY);
  }
}
