import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:icons_plus/icons_plus.dart';
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
  int lessonsCatagoryAnimateDuration = 2000;

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

  // void _scrollDown() {
  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeIn,
  //   );
  // }

  // void _scrollUp() {
  //   _scrollController.animateTo(
  //     0,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeOut,
  //   );
  // }

  Stream<Map<String, dynamic>> fetchTestScore(
      String email, String testType, int lessonIndex) {
    if (email == 'ไม่ได้เข้าสู่ระบบ') {
      return Stream.value(
          {'score': null, 'totalScore': null, 'testDate': null});
    }
    if (testType == 'pre-test') {
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
      }).handleError((error) {
        if (kDebugMode) {
          print('Error fetching pre-test score: $error');
        }
        return {'score': null, 'totalScore': null, 'testDate': null};
      });
    } else {
      return FirebaseFirestore.instance
          .collection('testResult')
          .doc(email)
          .collection(testType)
          .where('lessonTest', isEqualTo: lessonIndex)
          .orderBy('attemptCount', descending: true)
          .limit(1)
          .snapshots()
          .map((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.first.data();
        } else {
          return {'score': null, 'totalScore': null, 'testDate': null};
        }
      }).handleError((error) {
        if (kDebugMode) {
          print('Error fetching post-test score: $error');
        }
        return {'score': null, 'totalScore': null, 'testDate': null};
      });
    }
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
                UserData.email == 'ไม่ได้เข้าสู่ระบบ'
                    ? Text("$greetingWord ")
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            greetingWord,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 20.0,
                                  color: AppColor.primarSnakeColor
                                      .withOpacity(0.5),
                                  offset: const Offset(0.0, 5.0),
                                ),
                              ],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                            ),
                          ),
                          Text(
                            " ${UserData.userName}",
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  blurRadius: 20.0,
                                  color: AppColor.primarSnakeColor
                                      .withOpacity(0.5),
                                  offset: const Offset(0.0, 5.0),
                                ),
                              ],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesome.book_open_solid),
                    const SizedBox(width: 10),
                    Text(
                      "บทเรียน",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 20.0,
                            color: Theme.of(context).colorScheme.background,
                            offset: const Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).animate(
                  onPlay: (controller) => controller.repeat(),
                  effects: [
                    const ShimmerEffect(
                      angle: 2,
                      delay: Duration(milliseconds: 500),
                      duration: Duration(milliseconds: 1000),
                      color: AppColor.primarSnakeColor,
                    ),
                    const ShimmerEffect(
                      angle: 5,
                      delay: Duration(milliseconds: 1000),
                      duration: Duration(milliseconds: 1000),
                      color: Colors.amber,
                    ),
                  ],
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
                    Theme.of(context).colorScheme.background.withOpacity(0),
                  ],
                  stops: const [0.2, 1.0],
                ),
              ),
            ),
          ),
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
                            Stream.value(true),
                          ),
                        ),
                        Flexible(child: SizedBox(height: spaceSize)),
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
                          indicatorXY: 0.27,
                        ),
                        endChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "บทที่ $i ${LessonComponent.lessonContent[i].subTitle}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 25,
                                        ),
                                      ],
                                    ),
                                  ).animate(
                                    delay: Duration(milliseconds: 500 * i),
                                    onPlay: (controller) => controller.repeat(),
                                    effects: [
                                      ShimmerEffect(
                                          duration: Duration(
                                              milliseconds:
                                                  lessonsCatagoryAnimateDuration),
                                          color: AppColor.primarSnakeColor,
                                          angle: (0 + (10 * i)).toDouble()),
                                      ShimmerEffect(
                                        delay:
                                            const Duration(milliseconds: 500),
                                        duration: Duration(
                                            milliseconds:
                                                lessonsCatagoryAnimateDuration),
                                        color: Colors.amber,
                                        angle: (90 + (10 * i)).toDouble(),
                                      ),
                                      ShimmerEffect(
                                        delay:
                                            const Duration(milliseconds: 1000),
                                        duration: Duration(
                                            milliseconds:
                                                lessonsCatagoryAnimateDuration),
                                        color: Colors.cyan,
                                        angle: (270 + (10 * i)).toDouble(),
                                      ),
                                      ShimmerEffect(
                                        delay:
                                            const Duration(milliseconds: 1500),
                                        duration: Duration(
                                            milliseconds:
                                                lessonsCatagoryAnimateDuration),
                                        color: Colors.lime,
                                        angle: (180 + (10 * i)).toDouble(),
                                      ),
                                    ],
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
                                        "โปรดทำแบบทดสอบก่อนที่จะเริ่มเรียน";
                                    Color lessonColor = Colors.grey.shade100;
                                    if (score != null &&
                                        totalScore != null &&
                                        testDate != null) {
                                      String thaiMonth =
                                          thaiMonths[testDate.month] ?? '';
                                      int thaiYear = testDate.year + 543;
                                      subtitle =
                                          "$score/$totalScore คะแนน | ${testDate.day} $thaiMonth $thaiYear ${testDate.hour.toString().padLeft(2, '0')}:${testDate.minute.toString().padLeft(2, '0')} น.";
                                      lessonColor = AppColor.primarSnakeColor;
                                      // postTestColor = Theme.of(context)
                                      //     .colorScheme
                                      //     .background
                                    }
                                    return Column(
                                      children: [
                                        Card(
                                          elevation: 10,
                                          color:
                                              AppColor.primarSnakeColorAccent,
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
                                            Stream.value(true),
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

                                              return StreamBuilder<bool>(
                                                stream: checkLessonReadStatus(
                                                    UserData.email, i),
                                                builder: (context,
                                                    lessonReadSnapshot) {
                                                  String subtitle =
                                                      "ต้องเรียนบทนี้ก่อนทำแบบทดสอบนี้";
                                                  Color postTestColor =
                                                      Colors.grey.shade200;
                                                  if (lessonReadSnapshot
                                                          .hasData &&
                                                      lessonReadSnapshot
                                                          .data!) {
                                                    if (score != null &&
                                                        totalScore != null &&
                                                        testDate != null) {
                                                      String thaiMonth =
                                                          thaiMonths[testDate
                                                                  .month] ??
                                                              '';
                                                      int thaiYear =
                                                          testDate.year + 543;
                                                      subtitle =
                                                          "$score/$totalScore คะแนน | ${testDate.day} $thaiMonth $thaiYear ${testDate.hour.toString().padLeft(2, '0')}:${testDate.minute.toString().padLeft(2, '0')} น.";
                                                      postTestColor = AppColor
                                                          .primarSnakeColorAccent;
                                                    } else {
                                                      subtitle =
                                                          "ยังไม่ได้ทำแบบทดสอบ";
                                                      postTestColor = AppColor
                                                          .primarSnakeColorAccent;
                                                    }
                                                  }
                                                  return Card(
                                                    color: postTestColor,
                                                    elevation: 10,
                                                    child: lessonTitle(
                                                      "assets/icons/post_test.png",
                                                      "post_test_$i",
                                                      "แบบทดสอบหลังเรียนบทที่ $i",
                                                      subtitle,
                                                      TestingScreen
                                                          .postTest[i - 1],
                                                      context,
                                                      i,
                                                      'Post-test',
                                                      fetchTestScore(
                                                              UserData.email,
                                                              'pre-test',
                                                              i)
                                                          .map((data) =>
                                                              data['score'] !=
                                                              null),
                                                      checkLessonReadStatus(
                                                          UserData.email, i),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                              Flexible(child: SizedBox(height: spaceSize)),
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
    Stream<bool> isPreTestUnlocked,
    Stream<bool> isPostTestUnlocked,
  ) {
    return StreamBuilder<bool>(
      stream: isPreTestUnlocked,
      builder: (context, preTestSnapshot) {
        bool preTestUnlocked = preTestSnapshot.data ?? false;
        return StreamBuilder<bool>(
          stream: isPostTestUnlocked,
          builder: (context, postTestSnapshot) {
            bool postTestUnlocked = postTestSnapshot.data ?? false;
            bool unlocked = (type == 'Pre-test' && preTestUnlocked) ||
                (type == 'Lesson' && preTestUnlocked) ||
                (type == 'Post-test' && preTestUnlocked && postTestUnlocked);
            Color textColor = unlocked ? Colors.black : Colors.grey;
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
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    color: textColor),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis, color: textColor),
              ),
              trailing: type == 'Lesson'
                  ? StreamBuilder<bool>(
                      stream: _ContentScreenState.checkLessonReadStatus(
                          UserData.email, index),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.data == true) {
                          return const Icon(Icons.check, color: Colors.black);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    )
                  : null, // Only show the check status for the main lesson
              // tileColor: !unlocked ? Colors.grey : null,
              enabled: unlocked,
            );
          },
        );
      },
    );
  }
}

String _getGreetingWord() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 0 && hour < 4) {
    return '🌙 ราตรีสวัสดิ์';
  } else if (hour >= 4 && hour < 6) {
    return '🌅 สวัสดียามเช้าตรู่';
  } else if (hour >= 6 && hour < 12) {
    return '🌤️ อรุณสวัสดิ์';
  } else if (hour >= 12 && hour < 13) {
    return '🍚 สวัสดีตอนเที่ยง';
  } else if (hour >= 13 && hour < 16) {
    return '☀️ สวัสดียามบ่าย';
  } else if (hour >= 16 && hour < 18) {
    return '🌥️ สายัณห์สวัสดิ์';
  } else if (hour >= 18 && hour < 22) {
    return '🌙 สวัสดียามค่ำ';
  } else {
    return '🌃 สวัสดียามดึก';
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
