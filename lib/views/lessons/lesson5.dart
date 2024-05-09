import 'package:flutter/material.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/models/lesson_model.dart';
import 'package:pyoneer/utils/text.dart';

class Lesson5Screen extends StatefulWidget {
  const Lesson5Screen({super.key});

  @override
  State<Lesson5Screen> createState() => _Lesson5ScreenState();
}

class _Lesson5ScreenState extends State<Lesson5Screen> {
  @override
  Widget build(BuildContext context) {
    return LessonScreenModel(
      index: 5,
      lessonTitle: "Loops",
      youtubeVideoID: "LHBE6Q9XlzI",
      contentWidgets: [
        PyoneerText.contentText(
            "Loop คือ การทำงานด้วยกระบวนการทำงานเดิมๆ ซ้ำ หลายๆ รอบ​ ข้อมูลที่นำมาใช้ในกระบวนการทำงานเดิมซ้ำๆนั้น ไม่จำเป็นต้องเหมือนกันในแต่ละครั้งที่ทำซ้ำ รวมถึงผลลัพธ์ที่ได้จากการทำงานแต่ละครั้งด้วย ซึ่ง​เป็นเรื่องของกระบวนการทำงานที่แก้ไขปัญหาโพรเซสการทำงานที่มีการทำงานเดิมๆ ซ้ำ ​",tabSpace: true),
        PyoneerText.contentText("โดยหลักการของ Loop ที่ดีคือต้องรู้จบ โดยอาจจะต้องมีเงื่อนไขใดๆ ที่ระบุถึงการจบการทำงานเดิมๆ ซ้ำนั้น",tabSpace: true),
        PyoneerText.brakeLine(),
        PyoneerText.contentText(
          "while loop statement",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        PyoneerText.contentText(
            "เป็นคำสั่งของ Python ที่เหมาะสำหรับโพรเซสการทำงานที่ต้องมีการพิสูจน์/ตรวจสอบเงื่อนไขก่อนการทำงานใดๆ ซ้ำ โดยจะทำงานใดๆ ซ้ำตราบที่ผลการพิสูจน์/ตรวจสอบเงื่อนไขเป็นจริง",
            tabSpace: true),
        PyoneerText.brakeLine(10),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("รูปแบบ​", textDecoration: TextDecoration.underline),
          ],
        ),
        PyoneerText.contentText("   while  condition  :​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("                 statement(s)​", tabSpace: true, fontWeight: FontWeight.bold),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson5/lessonImage5-1.png",
        ),
        PyoneerText.brakeLine(),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 1", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson5/lessonImage5-2.png",
        ),
        PyoneerText.brakeLine(),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 2", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson5/lessonImage5-3.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText(
          "for loop statement",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        PyoneerText.contentText(
            "เป็นคำสั่งของ Python ที่เหมาะสำหรับโพรเซสการทำงานทำงานใดๆ ซ้ำ โดยจะทำงานใดๆ ซ้ำตามข้อกำหนด​",
            tabSpace: true),
        PyoneerText.brakeLine(10),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("รูปแบบ​", textDecoration: TextDecoration.underline),
          ],
        ),
        PyoneerText.contentText("   for  variable  in sequence :​​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("             statement(s)​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.brakeLine(),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 1", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage(// ใส่รูป
          context,
          "assets/images/lesson5/lessonImage5-4.png",
        ),
        PyoneerText.brakeLine(),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 2", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson5/lessonImage5-5.png",
        ),
        PyoneerText.brakeLine(),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 3", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson5/lessonImage5-6.png",
        ),
        PyoneerText.brakeLine(),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 4", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson5/lessonImage5-7.png",
        ),
        PyoneerText.brakeLine(),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 5", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson5/lessonImage5-8.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText(
          "break and loop statement​",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        PyoneerText.contentText(
            "break เป็นคำสั่งของ Python ที่เมื่ออยู่ใน Loop แล้วคำสั่ง break ทำงาน จะถือว่าจบการทำงานของ Loop ทันที โดยไม่สนใจคำสั่งที่เหลือ​",
            tabSpace: true),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("รูปแบบ​", textDecoration: TextDecoration.underline),
          ],
        ),
        PyoneerText.contentText("               break​​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText(
            "continue เป็นคำสั่งของ Python ที่เมื่ออยู่ใน Loop แล้วคำสั่ง continue ทำงาน จะถือว่าจบการทำงานของ Loop ในรอบการทำงานนั้น โดยไม่สนใจคำสั่งที่เหลือ และไปทำงานในรอบต่อไปทันที​",
            tabSpace: true),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("รูปแบบ​", textDecoration: TextDecoration.underline),
          ],
        ),
        PyoneerText.contentText("               continue", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.brakeLine(),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 1", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson5/lessonImage5-9.png",
        ),
        PyoneerText.brakeLine(),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 2", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson5/lessonImage5-10.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText(
          "Nested Loop statements​",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        PyoneerText.contentText(
            "เป็นคำสั่งของ Python ที่ใช้สำหรับการแก้ไขปัญหาในกระบวนการทำงานของโปรแกรมที่มีความซับซ้อนในกระบวนการทำงานเดิมๆ ซ้ำ ที่ซ้อนกันหลายชั้น​",
            tabSpace: true),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson5/lessonImage5-11.png",
        ),
        PyoneerText.brakeLine(50),
      ],
    );
  }
}
