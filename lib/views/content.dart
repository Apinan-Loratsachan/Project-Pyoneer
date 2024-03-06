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

class _ContentScreenState extends State<ContentScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _isAtBottom = false;
  bool _showFab = true;
  Timer? _hideFabTimer;

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
    _hideFabTimer = Timer(const Duration(seconds: 2), () {
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

  @override
  Widget build(BuildContext context) {
    String greetingWord = _getGreetingWord();
    return Scaffold(
      appBar: AppBar(
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
            const Text("บทเรียน")
          ],
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 100,
      ),
      floatingActionButton: _showFab
          ? (_isAtBottom
              ? FloatingActionButton(
                  backgroundColor: AppColor.primarSnakeColor.withOpacity(0.5),
                  foregroundColor: Colors.black,
                  onPressed: _scrollUp,
                  child: const Icon(Icons.arrow_upward),
                )
              : FloatingActionButton(
                  backgroundColor: AppColor.primarSnakeColor.withOpacity(0.5),
                  foregroundColor: Colors.black,
                  onPressed: _scrollDown,
                  child: const Icon(Icons.arrow_downward),
                ))
          : null,
      
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // ElevatedButton(
            //     onPressed: () => Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const Testing2Screen())),
            //     child: const Text('Test')),
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
                    indicatorXY: 0.5,
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
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
                      ),
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
                        isLast: i == 5 ? true : false,
                        indicatorStyle: const IndicatorStyle(
                          width: 40,
                          color: AppColor.primarSnakeColor,
                          indicatorXY: 0.5,
                        ),
                        endChild: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Card(
                                elevation: 10,
                                child: lessonTitle(
                                  "assets/icons/pre_test.png",
                                  "pre_test_$i",
                                  "แบบทดสอบก่อนเรียนบทที่ $i",
                                  "ทดสอบความรู้ก่อนที่คุณจะเรียนบทเรียน",
                                  TestingScreen.preTest[i - 1],
                                  context,
                                  i,
                                  'Pre-test',
                                ),
                              ),
                              Card(
                                elevation: 10,
                                shadowColor: AppColor.secondarySnakeColor,
                                color: AppColor.primarSnakeColor.withAlpha(255),
                                // surfaceTintColor: AppColor.secondarySnakeColor,
                                child: lessonTitle(
                                  LessonComponent.lessonContent[i].imageSrc,
                                  LessonComponent.lessonContent[i].heroTag,
                                  LessonComponent.lessonContent[i].title,
                                  LessonComponent.lessonContent[i].subTitle,
                                  LessonComponent.lessonContent[i].targetScreen,
                                  context,
                                  i,
                                  'Lesson',
                                ),
                              ),
                              Card(
                                elevation: 10,
                                child: lessonTitle(
                                  "assets/icons/post_test.png",
                                  "post_test_$i",
                                  "แบบทดสอบหลังเรียนบทที่ $i",
                                  "ทดสอบความรู้หลังจากที่คุณได้เรียนบทเรียน",
                                  TestingScreen.postTest[i - 1],
                                  context,
                                  i,
                                  'Post-test',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                // TimelineTile(
                //   alignment: TimelineAlign.manual,
                //   lineXY: 0.06,
                //   // isFirst: true,
                //   // isLast: true,
                //   indicatorStyle: const IndicatorStyle(
                //     width: 40,
                //     color: Colors.blue,
                //     indicatorXY: 0.5,
                //   ),
                //   endChild: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Card(
                //       child: Column(
                //         children: [
                //           lessonTitle(
                //             "assets/icons/pre_test.png",
                //             "pre_test_${2}",
                //             "แบบทดสอบก่อนเรียนบทที่ ${2}",
                //             "ทดสอบความรู้ก่อนที่คุณจะเรียนบทเรียน",
                //             const Testing2Screen(),
                //             context,
                //             2,
                //             'Pre-test',
                //           ),
                //           lessonTitle(
                //             LessonComponent.lessonContent[2].imageSrc,
                //             LessonComponent.lessonContent[2].heroTag,
                //             LessonComponent.lessonContent[2].title,
                //             LessonComponent.lessonContent[2].subTitle,
                //             LessonComponent.lessonContent[2].targetScreen,
                //             context,
                //             2,
                //             'Lesson',
                //           ),
                //           lessonTitle(
                //             "assets/icons/post_test.png",
                //             "post_test_${2}",
                //             "แบบทดสอบหลังเรียนบทที่ ${2}",
                //             "ทดสอบความรู้หลังจากที่คุณได้เรียนบทเรียน",
                //             const Testing2Screen(),
                //             context,
                //             2,
                //             'Post-test',
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // TimelineTile(
                //   alignment: TimelineAlign.manual,
                //   lineXY: 0.06,
                //   // isFirst: true,
                //   // isLast: true,
                //   indicatorStyle: const IndicatorStyle(
                //     width: 40,
                //     color: Colors.blue,
                //     indicatorXY: 0.5,
                //   ),
                //   endChild: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Card(
                //       child: Column(
                //         children: [
                //           lessonTitle(
                //             "assets/icons/pre_test.png",
                //             "pre_test_${3}",
                //             "แบบทดสอบก่อนเรียนบทที่ ${3}",
                //             "ทดสอบความรู้ก่อนที่คุณจะเรียนบทเรียน",
                //             const Testing2Screen(),
                //             context,
                //             3,
                //             'Pre-test',
                //           ),
                //           lessonTitle(
                //             LessonComponent.lessonContent[3].imageSrc,
                //             LessonComponent.lessonContent[3].heroTag,
                //             LessonComponent.lessonContent[3].title,
                //             LessonComponent.lessonContent[3].subTitle,
                //             LessonComponent.lessonContent[3].targetScreen,
                //             context,
                //             3,
                //             'Lesson',
                //           ),
                //           lessonTitle(
                //             "assets/icons/post_test.png",
                //             "post_test_${3}",
                //             "แบบทดสอบหลังเรียนบทที่ ${3}",
                //             "ทดสอบความรู้หลังจากที่คุณได้เรียนบทเรียน",
                //             const Testing2Screen(),
                //             context,
                //             3,
                //             'Post-test',
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // TimelineTile(
                //   alignment: TimelineAlign.manual,
                //   lineXY: 0.06,
                //   // isFirst: true,
                //   // isLast: true,
                //   indicatorStyle: const IndicatorStyle(
                //     width: 40,
                //     color: Colors.blue,
                //     indicatorXY: 0.5,
                //   ),
                //   endChild: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Card(
                //       child: Column(
                //         children: [
                //           lessonTitle(
                //             "assets/icons/pre_test.png",
                //             "pre_test_${4}",
                //             "แบบทดสอบก่อนเรียนบทที่ ${4}",
                //             "ทดสอบความรู้ก่อนที่คุณจะเรียนบทเรียน",
                //             const Testing2Screen(),
                //             context,
                //             4,
                //             'Pre-test',
                //           ),
                //           lessonTitle(
                //             LessonComponent.lessonContent[4].imageSrc,
                //             LessonComponent.lessonContent[4].heroTag,
                //             LessonComponent.lessonContent[4].title,
                //             LessonComponent.lessonContent[4].subTitle,
                //             LessonComponent.lessonContent[4].targetScreen,
                //             context,
                //             4,
                //             'Lesson',
                //           ),
                //           lessonTitle(
                //             "assets/icons/post_test.png",
                //             "post_test_${4}",
                //             "แบบทดสอบหลังเรียนบทที่ ${4}",
                //             "ทดสอบความรู้หลังจากที่คุณได้เรียนบทเรียน",
                //             const Testing2Screen(),
                //             context,
                //             4,
                //             'Post-test',
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // TimelineTile(
                //   alignment: TimelineAlign.manual,
                //   lineXY: 0.06,
                //   // isFirst: true,
                //   isLast: true,
                //   indicatorStyle: IndicatorStyle(
                //     width: 40,
                //     color: Colors.blue,
                //     indicatorXY: 0.5,
                //     iconStyle: IconStyle(
                //       color: Colors.white,
                //       iconData: Icons.lock_outline,
                //     ),
                //   ),
                //   endChild: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Card(
                //       child: Column(
                //         children: [
                //           lessonTitle(
                //             "assets/icons/pre_test.png",
                //             "pre_test_${5}",
                //             "แบบทดสอบก่อนเรียนบทที่ ${5}",
                //             "5/10 คะแนน",
                //             const Testing2Screen(),
                //             context,
                //             5,
                //             'Pre-test',
                //           ),
                //           lessonTitle(
                //             LessonComponent.lessonContent[5].imageSrc,
                //             LessonComponent.lessonContent[5].heroTag,
                //             LessonComponent.lessonContent[5].title,
                //             LessonComponent.lessonContent[5].subTitle,
                //             LessonComponent.lessonContent[5].targetScreen,
                //             context,
                //             5,
                //             'Lesson',
                //           ),
                //           lessonTitle(
                //             "assets/icons/post_test.png",
                //             "post_test_${5}",
                //             "แบบทดสอบหลังเรียนบทที่ ${5}",
                //             "ยังไม่ได้ทำแบบทดสอบ",
                //             const Testing2Screen(),
                //             context,
                //             5,
                //             'Post-test',
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  //-----------------------------------------------------------------------------------

  static Future<bool> checkLessonReadStatus(
      String email, int lessonIndex) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('lessons')
        .where('email', isEqualTo: email)
        .where('lessonRead', isEqualTo: lessonIndex)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Widget lessonTitle(
      String imageSrc,
      String heroTag,
      String title,
      String subtitle,
      Widget targetScreen,
      BuildContext context,
      int index,
      String type) {
    return ListTile(
      leading: Hero(
        tag: heroTag,
        child: Image.asset(imageSrc, width: 50, height: 50),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => targetScreen),
      ).then((_) => setState(() {})),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: type == 'Lesson'
          ? FutureBuilder<bool>(
              future: _ContentScreenState.checkLessonReadStatus(
                  UserData.email, index),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(); // Or some placeholder
                } else if (snapshot.data == true) {
                  return const Icon(
                    Icons.check,
                    // color: Color(0xFFae2325)
                    color: Colors.black
                  );
                } else {
                  return const SizedBox.shrink();
                  // return const Icon(Icons.radio_button_unchecked,
                  //     color: Colors.grey);
                }
              },
            )
          : null, // Only show the check status for the main lesson
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
