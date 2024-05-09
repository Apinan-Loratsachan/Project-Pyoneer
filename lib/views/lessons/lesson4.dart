import 'package:flutter/material.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/utils/text.dart';
import 'package:pyoneer/models/lesson_model.dart';

class Lesson4Screen extends StatefulWidget {
  const Lesson4Screen({super.key});

  @override
  State<Lesson4Screen> createState() => _Lesson4ScreenState();
}

class _Lesson4ScreenState extends State<Lesson4Screen> {
  @override
  Widget build(BuildContext context) {
    return LessonScreenModel(
      index: 4,
      lessonTitle: "Condition",
      youtubeVideoID: "Ej_02ICOIgs",
      contentWidgets: [
        PyoneerText.contentText("Condition (เงื่อนไข)",fontWeight: FontWeight.bold, fontSize: 20,),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("Condition คือ เงื่อนไข เป็นการพิสูจน์/ตรวจสอบ/ตัดสินใจ ​เป็นเรื่องของกระบวนการทำงานที่แก้ไขปัญหาโพรเซสการทำงานที่ต้องมีการพิสูจน์หรือตรวจสอบเงื่อนไขใดๆ ก่อนที่จะทำงาน​", tabSpace: true),
        PyoneerText.contentText("การพิสูจน์/ตรวจสอบ/ตัดสินใจ เงื่อนไขใดๆ ผลลัพธ์จะมีแค่จริง (True) หรือเท็จ (False) เท่านั้น​", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("รูปแบบของ Condition ", fontWeight: FontWeight.bold),
        PyoneerText.contentText("แบ่งเป็น 3 รูปแบบใหญ่​"),
        PyoneerText.contentText("if statement​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("- พิสูจน์/ตรวจสอบ ครั้งเดียวผลลัพธ์จากการพิสูจน์ตรวจสอบเป็นจริงจะมีคำสั่งการทำงานที่จะต้องทำ แต่หากเป็นเท็จจะไม่มีคำสั่งการทำงานที่จะต้องทำ​", tabSpace: true),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("รูปแบบ​", textDecoration: TextDecoration.underline),
          ],
        ),
        PyoneerText.contentText("   if  condition  :​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("         statement(s)​", tabSpace: true, fontWeight: FontWeight.bold),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-1.png",
        ),
        PyoneerText.brakeLine(20),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 1", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-2.png",
        ),
        PyoneerText.brakeLine(20),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 2", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-3.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("if…else statement​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("- พิสูจน์/ตรวจสอบ ครั้งเดียวผลลัพธ์จากการพิสูจน์ตรวจสอบเป็นจริงจะมีคำสั่งการทำงานที่จะต้องทำ และหากเป็นเท็จก็จะมีคำสั่งการงานที่จะต้องทำเช่นกัน​​", tabSpace: true),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("รูปแบบ​", textDecoration: TextDecoration.underline),
          ],
        ),
        PyoneerText.contentText("   if  condition  :​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("         statement(s)​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("   else  :​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("         statement(s)​", tabSpace: true, fontWeight: FontWeight.bold),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-4.png",
        ),
        PyoneerText.brakeLine(20),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 1", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-5.png",
        ),
        PyoneerText.brakeLine(20),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 2", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-6.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("if…elif…else statement​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("- พิสูจน์/ตรวจสอบ หลายครั้งโดยเป็นการพิสูจน์ไปที่ละเงื่อนไข (condition) และพิจารณาคำสั่งการทำงานไปทีละเงื่อนไขเมื่อผลการพิสูจน์เป็นจริง หรือเท็จ​", tabSpace: true),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("รูปแบบ​", textDecoration: TextDecoration.underline),
          ],
        ),PyoneerText.contentText("   if  condition  :​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("         statement(s)​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("   elif  condition :​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("         statement(s)​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("   elif  condition :​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("         statement(s)​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("   else :​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("         statement(s)​", tabSpace: true, fontWeight: FontWeight.bold),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-7.png",
        ),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 1", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-8.png",
        ),
        PyoneerText.brakeLine(20),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 2", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-9.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("การซ้อนคำสั่ง if (Nested if statements)", fontWeight: FontWeight.bold),
        PyoneerText.contentText("เป็นคำสั่งของ Python ที่ใช้สำหรับการแก้ไขปัญหาในกระบวนการทำงานของโปรแกรมที่มีความซับซ้อนในการพิสูจน์/ตรวจสอบ เงื่อนไขใดๆโดยการที่สามารถซ้อนคำสั่ง if ลงในคำสั่ง if อื่นอีกได้​", tabSpace: true),
        PyoneerText.brakeLine(20),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 1", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-10.png",
        ),
        PyoneerText.brakeLine(20),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 2", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-11.png",
        ),
        PyoneerText.brakeLine(20),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่างที่ 3", textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage( //ใส่รูป
          context,
          "assets/images/lesson4/lessonImage4-12.png",
        ),
        
        PyoneerText.brakeLine(50),
      ],
    );
  }
}