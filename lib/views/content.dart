import 'package:flutter/material.dart';
import 'package:pyoneer/utils/lesson_component.dart';
import 'package:pyoneer/views/lessons/lesson1.dart';
import 'package:pyoneer/views/lessons/lesson2.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

/// This class represents the state of the [ContentScreen] widget.
/// It extends the [State] class and overrides the [build] method to build the UI.
class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        centerTitle: true,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "hero-title",
                  child: Image.asset(
                    "assets/icons/pyoneer_snake.png",
                    fit: BoxFit.cover,
                    height: 60,
                  ),
                ),
                Image.asset(
                  "assets/icons/pyoneer_text.png",
                  fit: BoxFit.cover,
                  height: 40,
                )
              ],
            ),
            const SizedBox(height: 5),
            const Text("บทเรียน")
          ],
        ),
        toolbarHeight: 100,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20.0),
          ListTile(
            leading:
                LessonComponent.lessonCover('assets/images/lesson1/cover.jpg'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Lesson1Screen()),
            ),
            title: const Text(
              'บทเรียนที่ 1\nPython คืออะไร',
            ),
          ),
          ListTile(
            leading: Hero(
              tag: 'lesson-2-cover',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset('assets/images/lesson1/cover.jpg'),
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Lesson2Screen()),
            ),
            title: const Text(
              'บทเรียนที่ 2\nPython คืออะไร',
            ),
          ),
        ],
      ),
    );
  }
}
