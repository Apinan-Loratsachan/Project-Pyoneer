import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/views/testings/testing2.dart';
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
                        builder: (context) => const Testing2Screen())),
                child: const Text('Test')),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  LessonComponent.lessonContent.length,
                  (index) {
                    List<Widget> groupWidgets = [];

                    if (index != 0) {
                      // Pre-test Tile
                      groupWidgets.add(TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        isFirst: index == 1,
                        indicatorStyle: const IndicatorStyle(
                          width: 40,
                          color: Colors.blue,
                          indicatorXY: 0.5,
                        ),
                        endChild: lessonTitle(
                          "assets/icons/pyoneer_snake.png",
                          "pre_test_$index",
                          "แบบทดสอบก่อนเรียนบทที่ $index",
                          "ทดสอบความรู้ก่อนที่คุณจะเรียนบทเรียน",
                          const Testing2Screen(),
                          context,
                          index,
                          'Pre-test',
                        ),
                        beforeLineStyle: const LineStyle(
                          color: Colors.blue,
                          thickness: 2,
                        ),
                      ));
                    }

                    // Main Lesson Tile
                    groupWidgets.add(FutureBuilder<bool>(
                      future: _ContentScreenState.checkLessonReadStatus(
                          UserData.email, index),
                      builder: (context, snapshot) {
                        bool isRead = snapshot.data ?? false;
                        return TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                          indicatorStyle: IndicatorStyle(
                            width: 40,
                            color: isRead ? Colors.green : Colors.grey,
                            indicatorXY: 0.5,
                          ),
                          endChild: lessonTitle(
                            LessonComponent.lessonContent[index].imageSrc,
                            LessonComponent.lessonContent[index].heroTag,
                            LessonComponent.lessonContent[index].title,
                            LessonComponent.lessonContent[index].subTitle,
                            LessonComponent.lessonContent[index].targetScreen,
                            context,
                            index,
                            'Lesson',
                          ),
                          beforeLineStyle: LineStyle(
                            color: isRead ? Colors.green : Colors.grey,
                            thickness: 2,
                          ),
                        );
                      },
                    ));

                    if (index != 0) {
                      // Post-test Tile
                      groupWidgets.add(TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        isLast:
                            index == LessonComponent.lessonContent.length - 1,
                        indicatorStyle: const IndicatorStyle(
                          width: 40,
                          color: Colors.red,
                          indicatorXY: 0.5,
                        ),
                        endChild: lessonTitle(
                          "assets/icons/pyoneer_snake.png",
                          "post_test_$index",
                          "แบบทดสอบหลังเรียนบทที่ $index",
                          "ทดสอบความรู้หลังจากที่คุณได้เรียนบทเรียน",
                          const Testing2Screen(),
                          context,
                          index,
                          'Post-test',
                        ),
                        beforeLineStyle: const LineStyle(
                          color: Colors.red,
                          thickness: 2,
                        ),
                      ));
                    }
                    if (index < LessonComponent.lessonContent.length - 1) {
                      groupWidgets.add(const SizedBox(height: 20));
                    }

                    return Column(children: groupWidgets);
                  },
                )),
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
                  return const Icon(Icons.check_circle, color: Colors.green);
                } else {
                  return const Icon(Icons.radio_button_unchecked,
                      color: Colors.grey);
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
