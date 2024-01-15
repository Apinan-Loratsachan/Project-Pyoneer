import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';
import 'package:pyoneer/views/lessons/lesson0.dart';
import 'package:pyoneer/views/lessons/lesson1.dart';
import 'package:pyoneer/views/lessons/lesson2.dart';
import 'package:pyoneer/views/lessons/lesson3.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
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
      ),
      subtitle: Text(
        subtitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("บทเรียน"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          lessonTitle(LessonComponent.lessonImageSrc[0], LessonComponent.heroTag[0], LessonComponent.lessonTitle[0], LessonComponent.lessonSubTitle[0], const Lesson0Screen()),
          lessonTitle(LessonComponent.lessonImageSrc[1], LessonComponent.heroTag[1], LessonComponent.lessonTitle[1], LessonComponent.lessonSubTitle[1], const Lesson1Screen()),
          lessonTitle(LessonComponent.lessonImageSrc[2], LessonComponent.heroTag[2], LessonComponent.lessonTitle[2], LessonComponent.lessonSubTitle[2], const Lesson2Screen()),
          lessonTitle(LessonComponent.lessonImageSrc[3], LessonComponent.heroTag[3], LessonComponent.lessonTitle[3], LessonComponent.lessonSubTitle[3], const Lesson3Screen()),
        ],
      ),
    );
  }
}
