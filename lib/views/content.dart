import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              List.generate(LessonComponent.lessonContent.length, (index) {
            return FutureBuilder<bool>(
              future: checkLessonReadStatus(UserData.email, index),
              builder: (context, snapshot) {
                bool isRead = snapshot.data ?? false;
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  isFirst: index == 0,
                  isLast: index == LessonComponent.lessonContent.length - 1,
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
          }),
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
