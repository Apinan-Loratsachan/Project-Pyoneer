import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';
import 'package:pyoneer/views/lessons/lesson0.dart';
import 'package:pyoneer/views/lessons/lesson1.dart';
import 'package:pyoneer/views/lessons/lesson2.dart';
import 'package:pyoneer/views/lessons/lesson3.dart';
import 'package:pyoneer/views/lessons/lesson4.dart';
import 'package:pyoneer/views/lessons/lesson5.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  ListTile lessonTitle(String imageSrc, String heroTag, String title,
      String subtitle, Widget targetScreen) {
    return ListTile(
      leading: LessonComponent.lessonCover(imageSrc, heroTag, true),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => targetScreen),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(
        subtitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "บทเรียน",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            lessonTitle(
                LessonComponent.lessonImageSrc[0],
                LessonComponent.heroTag[0],
                LessonComponent.lessonTitle[0],
                LessonComponent.lessonSubTitle[0],
                const Lesson0Screen()),
            lessonTitle(
                LessonComponent.lessonImageSrc[1],
                LessonComponent.heroTag[1],
                LessonComponent.lessonTitle[1],
                LessonComponent.lessonSubTitle[1],
                const Lesson1Screen()),
            lessonTitle(
                LessonComponent.lessonImageSrc[2],
                LessonComponent.heroTag[2],
                LessonComponent.lessonTitle[2],
                LessonComponent.lessonSubTitle[2],
                const Lesson2Screen()),
            lessonTitle(
                LessonComponent.lessonImageSrc[3],
                LessonComponent.heroTag[3],
                LessonComponent.lessonTitle[3],
                LessonComponent.lessonSubTitle[3],
                const Lesson3Screen()),
            lessonTitle(
                LessonComponent.lessonImageSrc[4],
                LessonComponent.heroTag[4],
                LessonComponent.lessonTitle[4],
                LessonComponent.lessonSubTitle[4],
                const Lesson4Screen()),
            lessonTitle(
                LessonComponent.lessonImageSrc[5],
                LessonComponent.heroTag[5],
                LessonComponent.lessonTitle[5],
                LessonComponent.lessonSubTitle[5],
                const Lesson5Screen()),
          ],
        ),
      ),
    );
  }
}
