import 'package:flutter/material.dart';

class LessonComponent {
  static AppBar lessonsAppbar(String titleText) {
    return AppBar(
      title: Row(
        children: [
          const SizedBox(width: 0),
          Hero(
            tag: "hero-title",
            child: Image.asset(
              "assets/icons/pyoneer_snake.png",
              fit: BoxFit.cover,
              height: 60,
            ),
          ),
          const SizedBox(width: 10),
          Text(titleText)
        ],
      ),
      toolbarHeight: 70,
    );
  }

  static Hero lessonCover(String imagePath) {
    return Hero(
      tag: 'lesson-cover',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(imagePath),
      ),
    );
  }
}
