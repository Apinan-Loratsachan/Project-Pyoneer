import 'package:flutter/material.dart';
import 'package:pyoneer/models/Lesson_screen_model.dart';

class Lesson3Screen extends StatelessWidget {
  const Lesson3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LessonScreenModel(
      appBarTitle: 'Lesson 3',
      coverImagePath: 'assets/images/lesson1/cover.png',
      heroTag: "lesson-3-cover",
      lessonTitle: "",
      contentWidgets: [
        
      ],
    );
  }
}
