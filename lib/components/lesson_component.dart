import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pyoneer/utils/type_writer_text.dart';
import 'package:pyoneer/views/lessons/lesson0.dart';
import 'package:pyoneer/views/lessons/lesson1.dart';
import 'package:pyoneer/views/lessons/lesson2.dart';
import 'package:pyoneer/views/lessons/lesson3.dart';
import 'package:pyoneer/views/lessons/lesson4.dart';
import 'package:pyoneer/views/lessons/lesson5.dart';

class LessonContent {
  String imageSrc;
  String title;
  String subTitle;
  String heroTag;
  Widget targetScreen;

  LessonContent({
    required this.imageSrc,
    required this.title,
    required this.subTitle,
    required this.heroTag,
    required this.targetScreen,
  });
}

class LessonComponent {
  static List<LessonContent> lessonContent = [
    LessonContent(
        imageSrc: "assets/images/lesson0/cover.png",
        title: "บทนำ",
        subTitle: "Python คืออะไร",
        heroTag: "lesson-0-cover",
        targetScreen: const Lesson0Screen()),
    LessonContent(
        imageSrc: "assets/images/lesson1/cover.png",
        title: "บทเรียนที่ 1",
        subTitle: "คุณลักษณะของภาษา Python 5555555555555555555555555555555",
        heroTag: "lesson-1-cover",
        targetScreen: const Lesson1Screen()),
    LessonContent(
        imageSrc: "assets/images/lesson2/cover.png",
        title: "บทเรียนที่ 2",
        subTitle: "ตัวแปรและการกำหนดค่า",
        heroTag: "lesson-2-cover",
        targetScreen: const Lesson2Screen()),
    LessonContent(
        imageSrc: "assets/images/lesson3/cover.png",
        title: "บทเรียนที่ 3",
        subTitle: "ชนิดข้อมูล",
        heroTag: "lesson-3-cover",
        targetScreen: const Lesson3Screen()),
    LessonContent(
        imageSrc: "assets/images/lesson4/cover.png",
        title: "บทเรียนที่ 4",
        subTitle: "ตัวดำเนินการและนิพจน์",
        heroTag: "lesson-4-cover",
        targetScreen: const Lesson4Screen()),
    LessonContent(
        imageSrc: "assets/images/lesson5/cover.png",
        title: "บทเรียนที่ 5",
        subTitle: "คำสั่งรับค่าและแสดงผล",
        heroTag: "lesson-5-cover",
        targetScreen: const Lesson5Screen()),
  ];

  static AppBar lessonsAppbar(String title, String subTitleText, context) {
    return AppBar(
      leading: IconButton(onPressed: () {
        Navigator.pop(context, true);
      }, icon: const Icon(Icons.arrow_back)),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TypeWriterText(
                    text: title,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TypeWriterText(
                    text: subTitleText,
                    cursorSpeed: 700,
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      toolbarHeight: 70,
    );
  }

  static Hero lessonCover(String imagePath, String heroTag,
      [bool listTile = false]) {
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          imagePath,
          width: listTile ? 60 : double.infinity,
        ),
      ),
    );
  }

  static Widget lessonImage(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            var screenSize = MediaQuery.of(context).size;

            var width = screenSize.width;
            var height = screenSize.height;

            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: PhotoView(
                      imageProvider: AssetImage(
                        imagePath,
                      ),
                      minScale: PhotoViewComputedScale.contained * 1,
                      maxScale: PhotoViewComputedScale.covered * 4.0,
                      initialScale: PhotoViewComputedScale.contained,
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      basePosition: Alignment.center,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Image.asset(
        imagePath,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Text(
            'ไม่พบรูปภาพ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              decoration: TextDecoration.lineThrough,
            ),
          );
        },
      ),
    );
  }
}
