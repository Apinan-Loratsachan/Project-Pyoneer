import 'package:flutter/material.dart';
import 'package:pyoneer/components/lesson_component.dart';
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
      index: 1,
      lessonTitle: "คุณลักษณะ\nของภาษาไพทอน",
      youtubeVideoID: "eWRfhZUzrAc",
      contentWidgets: [
        PyoneerText.contentText("คุณลักษณะของภาษาไพทอน",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.contentText("${PyoneerText.startParagraph}ภาษาไพทอนเป็นภาษาที่นำลักษณะที่ดีของภาษาที่มีอยู่ก่อนแล้ว คือ ABC, Modula-3, C, C++, Algol-68, SmallTalk and Unix shell and other scripting languages และเพิ่มคุณลักษณะที่ดี เช่น คลาสและอื่นๆ รวมถึงมี interface ที่เข้าใจได้ง่ายทำให้การเขียนโปรแกรมสะดวกมากขึ้น"),
        PyoneerText.contentText("ภาษาไพทอนเป็นภาษาระดับสูง และจัดอยู่ในกลุ่มภาษา Interpreter คือ แปลแล้วทำงานทีละคำสั่ง มีการประมวลผลทันที (process at runtime) นอกจากนี้ยังมีลักษณะ interactive คือ เราสามารถพิมพ์คำสั่ง ทำงานในลักษณะตอบโต้ได้ และเป็นภาษาที่ได้รับความนิยม เรียนรู้ได้ง่าย เหมาะกับผู้เริ่มต้นเขียนโปรแกรม", tabSpace: true),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("การอ่านภาษาไพทอนเบื้องต้น",boxAlign: Alignment.center),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson1/lessonImage1-1.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("\nการทำงานของภาษาไพทอนเบื้องต้น", textAlign: TextAlign.center, boxAlign: Alignment.center),
        PyoneerText.contentText("\nภาษาไพทอน execute ได้ 2 mode คือ${PyoneerText.startParagraph}1. Interactive Mode Programmimg : เป็น mode ที่เราพิมพ์คำสั่ง ภาษาไพทอนจะแปลและทำงานทันที เช่น"),
        PyoneerText.brakeLine(),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson1/lessonImage1-2.png",
        ),
        PyoneerText.contentText("ดังภาพ จะเห็นว่า เมื่อสั่งให้ทำงานด้วยคำสั่ง print ระบบจะทำการทำงานทันทีก่อนที่จะรับคำสั่งใหม่", textAlign: TextAlign.center, fontSize: 16),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("${PyoneerText.startParagraph}2. Script Mode Programming : พิมพ์คำสั่งหรือโปรแกรมที่ editor หรือ IDLE ของไพทอน  (write a simple Python program in a script) จากนั้น save file และกำหนด file type เป็น .py (ไฟล์ภาษาไพทอน) เมื่อรันโปรแกรมจะได้ผลลัพธ์ ดังภาพ"),
        PyoneerText.brakeLine(),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson1/lessonImage1-3.png",
        ),
        PyoneerText.contentText("จากภาพ คือไฟล์  welcome.py ที่มีคำสั่ง print “Welcome to Python!” อยู่ภายใน เมื่อรันโปรแกรม จะได้ Welcome to Python!", textAlign: TextAlign.center, fontSize: 16),
        PyoneerText.brakeLine(50),
      ],
    );
  }
}
