import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/views/testings/testing1.dart';
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
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text("บทเรียน")
          ],
        ),
        centerTitle: true,
        surfaceTintColor: Colors.white,
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
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Testing1Screen())),
                child: const Text('Test')),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                LessonComponent.lessonContent.length,
                (index) {
                  return FutureBuilder<bool>(
                    future: checkLessonReadStatus(UserData.email, index),
                    builder: (context, snapshot) {
                      bool isRead = snapshot.data ?? false;
                      return TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        isFirst: index == 0,
                        isLast:
                            index == LessonComponent.lessonContent.length - 1,
                        indicatorStyle: IndicatorStyle(
                          width: 40,
                          height: 30,
                          indicator: Container(
                            decoration: BoxDecoration(
                              color: isRead ? Colors.green : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isRead
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                        ),
                        endChild: lessonTitle(
                          LessonComponent.lessonContent[index].imageSrc,
                          LessonComponent.lessonContent[index].heroTag,
                          LessonComponent.lessonContent[index].title,
                          LessonComponent.lessonContent[index].subTitle,
                          LessonComponent.lessonContent[index].targetScreen,
                          context,
                          index,
                        ),
                        beforeLineStyle: LineStyle(
                          color: isRead ? Colors.green : Colors.grey,
                          thickness: 2,
                        ),
                      );
                    },
                  );
                },
              ),
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

  ListTile lessonTitle(String imageSrc, String heroTag, String title,
      String subtitle, Widget targetScreen, BuildContext context, int index) {
    return ListTile(
      leading: LessonComponent.lessonCover(imageSrc, heroTag, true),
      onTap: () async {
        if (UserData.email != 'ไม่ได้เข้าสู่ระบบ') {
          // Navigate to the target screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          ).then((value) {
            setState(() {});
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        }
      },
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
      ),
      // trailing: FutureBuilder<bool>(
      //   future: checkLessonReadStatus(UserData.email, index),
      //   builder: (context, snapshot) {
      //     Widget child;
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       child = const SizedBox();
      //     } else if (snapshot.data! != true) {
      //       child = const Icon(
      //         Icons.check_circle_rounded,
      //         color: Colors.transparent,
      //       );
      //     } else {
      //       child = const Icon(
      //         Icons.check_circle_rounded,
      //         color: Colors.green,
      //       );
      //     }
      //     return AnimatedSwitcher(
      //       duration: const Duration(seconds: 1),
      //       child: child,
      //     );
      //   },
      // ),
    );
  }
}

String _getGreetingWord() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  // ตั้งแต่ตี 4 ถึง 11:59 นาฬิกาเช้า
  // ตั้งแต่ 12 ถึง 15:59 นาฬิกาเที่ยง
  // ตั้งแต่ 16 ถึง 18:59 นาฬิกาเย็น
  // ตั้งแต่ 19 ถึง 3:59 นาฬิกากลางคืน
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
