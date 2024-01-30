import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pyoneer/utils/type_writer_text.dart';

class LessonComponent {
  static List<String> lessonImageSrc = [
    "assets/images/lesson0/cover.png",
    "assets/images/lesson1/cover.png",
    "assets/images/lesson2/cover.png",
    "assets/images/lesson3/cover.png",
    "assets/images/lesson4/cover.png",
    "assets/images/lesson5/cover.png",
  ];
  static List<String> lessonTitle = [
    "บทนำ",
    "บทเรียนที่ 1",
    "บทเรียนที่ 2",
    "บทเรียนที่ 3",
    "บทเรียนที่ 4",
    "บทเรียนที่ 5",
    "บทเรียนที่ 6",
    "บทเรียนที่ 7",
    "บทเรียนที่ 8",
    "บทเรียนที่ 9",
    "บทเรียนที่ 10",
  ];
  static List<String> lessonSubTitle = [
    "Python คืออะไร",
    "คุณลักษณะของภาษา Python",
    "ตัวแปรและการกำหนดค่า",
    "ชนิดข้อมูล",
    "ตัวดำเนินการและนิพจน์",
    "คำสั่งรับค่าและแสดงผล",
    "บทเรียนที่ 6",
    "บทเรียนที่ 7",
    "บทเรียนที่ 8",
    "บทเรียนที่ 9",
    "บทเรียนที่ 10",
  ];
  static List<String> heroTag = [
    "lesson-0-cover",
    "lesson-1-cover",
    "lesson-2-cover",
    "lesson-3-cover",
    "lesson-4-cover",
    "lesson-5-cover",
    "lesson-6-cover",
    "lesson-7-cover",
    "lesson-8-cover",
    "lesson-9-cover",
    "lesson-10-cover",
  ];

  static AppBar lessonsAppbar(String title, String subTitleText) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TypeWriterText(
                  text: title,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
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
