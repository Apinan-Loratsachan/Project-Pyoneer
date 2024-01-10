import 'package:flutter/material.dart';
import 'package:pyoneer/utils/lesson_component.dart';
import 'package:pyoneer/views/lessons/lesson1.dart';
import 'package:pyoneer/views/lessons/lesson2.dart';
import 'package:pyoneer/views/lessons/lesson3.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  
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
          ListTile(
            leading:
                LessonComponent.lessonCover('assets/images/lesson1/cover.png', 'lesson-1-cover'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Lesson1Screen()),
            ),
            title: const Text(
              'บทเรียนที่ 1\nPython คืออะไร',
            ),
          ),
          ListTile(
            leading: LessonComponent.lessonCover('assets/images/lesson1/cover.png', 'lesson-2-cover'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Lesson2Screen()),
            ),
            title: const Text(
              'บทเรียนที่ 2\nPython คืออะไร',
            ),
          ),
          ListTile(
            leading: LessonComponent.lessonCover('assets/images/lesson1/cover.png', 'lesson-3-cover'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Lesson3Screen()),
            ),
            title: const Text(
              'บทเรียนที่ 3\nPython คืออะไร',
            ),
          ),
        ],
      ),
    );
  }
}
