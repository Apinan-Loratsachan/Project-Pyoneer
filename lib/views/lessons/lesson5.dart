import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';
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
      appBarTitle: LessonComponent.lessonTitle[5],
      appBarSubTitle: LessonComponent.lessonSubTitle[5],
      coverImagePath: LessonComponent.lessonImageSrc[5],
      heroTag: LessonComponent.heroTag[5],
      lessonTitle: "คำสั่งรับค่า\nและ การแสดงผล",
      contentWidgets: [
        PyoneerText.contentText("การทำงานเพื่อติดต่อกับผู้ใช้ เราสามารถเรียกใช้ฟังก์ชั่นเพื่อรับ หรือแสดงผลลักษณะของฟังก์ชั่น คือ คำสั่งหลายๆ คำสั่ง ที่สร้างไว้แล้ว เราสามารถเรียกใช้ได้แต่ต้องเป็นไปตามรูปแบบที่กำหนด ในส่วนนี้ เพื่อรับและแสดงผล เราจะศึกษาดังนี้",tabSpace: true),
        PyoneerText.contentText("คำสั่งแสดงผล ใช้ฟังก์ชั่น print()",tabSpace: true),
        PyoneerText.contentText("คำสั่งรับข้อมูล ใช้ฟังก์ชั่น input()",tabSpace: true),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("คำสั่งการแสดงผล",fontWeight: FontWeight.bold, fontSize: 20,),
        PyoneerText.contentText("ใช้ฟังก์ชั่น print() เพื่อแสดงผลที่จอภาพ ในเครื่องหมาย () จะส่งข้อมูล : ตัวแปร, ข้อความ เพื่อแสดงผลที่จอภาพ ข้อมูลแยกด้วยเครื่องหมาย ,",tabSpace: true),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson5/lessonImage5-1.png",
        ),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("นอกจากนี้ หากเราต้องการแสดงผล การขึ้นบรรทัดใหม่ ใช้ \\n",tabSpace: true),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ตัวอย่าง",textDecoration: TextDecoration.underline),
        
        
        
        
        
        
        
        
        
        
        
        
        
        PyoneerText.brakeLine(50),
      ],
    );
  }
}