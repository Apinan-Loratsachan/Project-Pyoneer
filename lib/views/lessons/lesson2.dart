import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';
import 'package:pyoneer/utils/text.dart';
import 'package:pyoneer/models/lesson_model.dart';

class Lesson2Screen extends StatefulWidget {
  const Lesson2Screen({super.key});

  @override
  State<Lesson2Screen> createState() => _Lesson2ScreenState();
}

class _Lesson2ScreenState extends State<Lesson2Screen> {
  @override
  Widget build(BuildContext context) {
    return LessonScreenModel(
      appBarTitle: LessonComponent.lessonContent[2].title,
      appBarSubTitle: LessonComponent.lessonContent[2].subTitle,
      coverImagePath: LessonComponent.lessonContent[2].imageSrc,
      heroTag: LessonComponent.lessonContent[2].heroTag,
      lessonTitle: "ตัวแปร และ\nการกำหนดค่า",
      contentWidgets: [
        PyoneerText.contentText("ตัวแปร (variable)",fontWeight: FontWeight.bold, fontSize: 20,),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("ตัวแปรจะจองเนื้อที่ในหน่วยความจำ ขนาดหรือเนื้อที่ที่ใช้ ขึ้นอยู่กับชนิดข้อมูล มีข้อกำหนดในการตั้งชื่อตัวแปร ดังนี้", tabSpace: true),
        PyoneerText.contentText("1. ตัวอักษรตัวแรกต้องเป็นตัวอักษร A-Z หรือ a-z หรือเครื่องหมาย _ (Underscore) เท่านั้น", tabSpace: true),
        PyoneerText.contentText("2. ตัวอักษรตัวอื่นๆ ต้องเป็นตัวอักษร A-Z หรือ a-z หรือตัวเลข 0-9 หรือเครื่องหมาย _ (Underscore) เท่านั้น", tabSpace: true),
        PyoneerText.contentText("3. ห้ามตั้งชื่อตัวแปรซ้ำกับคำสงวน (Reserved Word)", tabSpace: true),
        PyoneerText.contentText("4. ห้ามมีช่องว่างภายในชื่อ", tabSpace: true),
        PyoneerText.contentText("5. ตัวอักษรตัวพิมพ์เล็กและตัวพิมพ์ใหญ่ถือว่าต่างกัน เช่น NUM , Num และ num เป็นตัวแปรคนละตัวกัน", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("คำที่เป็น Reserved words", textDecoration: TextDecoration.underline, boxAlign: Alignment.center),
        PyoneerText.brakeLine(5),
        PyoneerText.contentText("and exec not assert finally or ", boxAlign: Alignment.center, textAlign: TextAlign.center, textSpaceSpan: true),
        PyoneerText.brakeLine(5),
        PyoneerText.contentText("break for pass class from print", boxAlign: Alignment.center, textAlign: TextAlign.center, textSpaceSpan: true),
        PyoneerText.brakeLine(5),
        PyoneerText.contentText("continue global raise def if return", boxAlign: Alignment.center, textAlign: TextAlign.center, textSpaceSpan: true),
        PyoneerText.brakeLine(5),
        PyoneerText.contentText("del import try elif in while", boxAlign: Alignment.center, textAlign: TextAlign.center, textSpaceSpan: true),
        PyoneerText.brakeLine(5),
        PyoneerText.contentText("else is with except lambda yield ", boxAlign: Alignment.center, textAlign: TextAlign.center, textSpaceSpan: true),
        PyoneerText.brakeLine(),
        PyoneerText.divider(50),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("การกำหนดค่าให้ตัวแปร\n(assignment statement)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.contentText("${PyoneerText.startParagraph}ตัวแปรในภาษาไพทอนนั้นไม่ต้องประกาศชนิดข้อมูลให้ตัวแปรก่อนทำงาน การประกาศจะเกิดขึ้นโดยอัตโนมัติเมื่อเรากำหนดค่าให้ตัวแปรโดยใช้เครื่องหมาย = (เท่ากับ)"),
        PyoneerText.brakeLine(15),
        PyoneerText.contentText("ตัวอย่าง"),
        PyoneerText.contentText("score = 75", tabSpace: true),
        PyoneerText.contentText("gpa = 2.85", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("หมายความว่า"),
        PyoneerText.contentText("ตัวแปร score เป็นจำนวนเต็ม มีค่า 75", tabSpace: true),
        PyoneerText.contentText("ตัวแปร gpa เป็นจำนวนจริง มีค่า 2.85", tabSpace: true),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ตัวอย่างการกำหนดค่า",textDecoration: TextDecoration.underline),
        PyoneerText.contentText("เราสามารถกำหนดค่าในลักษณะ multiple assignment ได้ดังนี้ เช่น"),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("a = b = c = 1", tabSpace: true),
        PyoneerText.brakeLine(5),
        PyoneerText.contentText("หมายความว่า ตัวแปร  a b c เป็นจำนวนเต็มมีค่า 1"),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("a, b, c = 1, 2, \"john\"", tabSpace: true),
        PyoneerText.brakeLine(5),
        PyoneerText.contentText("หมายความว่า ตัวแปร a b c มีค่าเป็น 1 2 และ john ตามลำดับ"),
        PyoneerText.brakeLine(50),
      ],
    );
  }
}
