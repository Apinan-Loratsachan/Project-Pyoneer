import 'package:flutter/material.dart';
import 'package:pyoneer/utils/lesson_component.dart';
import 'package:pyoneer/utils/text.dart';
import 'package:pyoneer/models/lesson_model.dart';

class Lesson1Screen extends StatefulWidget {
  const Lesson1Screen({super.key});

  @override
  State<Lesson1Screen> createState() => _Lesson1ScreenState();
}

class _Lesson1ScreenState extends State<Lesson1Screen> {
  @override
  Widget build(BuildContext context) {
    return LessonScreenModel(
      appBarTitle: "Lesson 1",
      coverImagePath: "assets/images/lesson1/cover.png",
      heroTag: "lesson-1-cover",
      lessonTitle: "Python คืออะไร",
      contentWidgets: [
        const Text(
          "คุณลักษณะของภาษาไพทอน\n${PyoneerText.startParagraph}ภาษาไพทอนเป็นภาษาที่นำลักษณะที่ดีของภาษาที่มีอยู่ก่อนแล้ว คือ ABC, Modula-3, C, C++, Algol-68, SmallTalk and Unix shell and other scripting languages และเพิ่มคุณลักษณะที่ดี เช่น คลาสและอื่นๆ รวมถึงมี interface ที่เข้าใจได้ง่ายทำให้การเขียนโปรแกรมสะดวกมากขึ้น",
        ),
        //const SizedBox(height: PyoneerText.textSpaceSize),
        const Text(
          "${PyoneerText.startParagraph}ภาษาไพทอนเป็นภาษาระดับสูง และจัดอยู่ในกลุ่มภาษา Interpreter คือ แปลแล้วทำงานทีละคำสั่ง มีการประมวลผลทันที (process at runtime) นอกจากนี้ยังมีลักษณะ interactive คือ เราสามารถพิมพ์คำสั่ง ทำงานในลักษณะตอบโต้ได้ และเป็นภาษาที่ได้รับความนิยม เรียนรู้ได้ง่าย เหมาะกับผู้เริ่มต้นเขียนโปรแกรม",
        ),
        const SizedBox(
          height: PyoneerText.textSpaceSize,
        ),
        const Text(
          "การอ่านภาษาไพทอนเบื้องต้น",
          style: TextStyle(
            fontSize: PyoneerText.bodyTextSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        LessonComponent().lessonImage(
          context,
          "assets/images/lesson1/lessonImage1-1.png",
        ),
        const SizedBox(
          height: PyoneerText.textSpaceSize,
        ),
        const Text(
          'การทำงานของภาษาไพทอนเบื้องต้น',
          style: TextStyle(
            fontSize: PyoneerText.bodyTextSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        const Text(
          "\nภาษาไพทอน execute ได้ 2 mode คือ\n\n1. INTERACTIVE MODE PROGRAMMING : เป็น mode ที่เราพิมพ์คำสั่ง ภาษาไพทอนจะแปลและทำงานทันที เช่น\n",
        ),
        LessonComponent().lessonImage(
          context,
          "assets/images/lesson1/lessonImage1.jpg",
        ),
        const SizedBox(height: PyoneerText.textSpaceSize),
        const Text(
          "ดังภาพ จะเห็นว่า เมื่อสั่งให้ทำงานด้วยคำสั่ง print ระบบจะทำการทำงานทันทีก่อนที่จะรับคำสั่งใหม่",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
