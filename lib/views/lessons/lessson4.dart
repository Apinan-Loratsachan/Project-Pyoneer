import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';
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
      appBarTitle: LessonComponent.lessonTitle[4],
      appBarSubTitle: LessonComponent.lessonSubTitle[4],
      coverImagePath: LessonComponent.lessonImageSrc[4],
      heroTag: LessonComponent.heroTag[4],
      lessonTitle: "ตัวดำเนินการและนิพจน์",
      contentWidgets: [
        PyoneerText.contentText("ตัวดำเนินการ (Operator)",fontWeight: FontWeight.bold, fontSize: 20,),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("คือ การดำเนินการทางคณิตศาสตร์ หรือการดำเนินการทางตรรกศาสตร์ ซึ่งมักจะเป็นเครื่องหมายหรือสัญลักษณ์พิเศษต่างๆมี 7 ประเภท คือ", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("ตัวดำเนินการทางคณิตศาสตร์", fontWeight: FontWeight.bold,),
        PyoneerText.contentText("(Arithmetic Operators)", fontWeight: FontWeight.bold,),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson4/lessonImage4-1.png",
        ),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("* ตัวอย่างเช่น 17 / 3 จะได้เป็น float 5.666666"),
        PyoneerText.contentText("\t\t\t17 // 3 เป็นการหารแบบเอาแต่ส่วน คำตอบจึงเป็น 5"),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ตัวดำเนินการเปรียบเทียบ", fontWeight: FontWeight.bold,),
        PyoneerText.contentText("(Comparison Operators)", fontWeight: FontWeight.bold,),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson4/lessonImage4-2.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ตัวดำเนินการกำหนดค่า (Assignment Operators)", fontWeight: FontWeight.bold,),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson4/lessonImage4-3.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ตัวดำเนินการทางตรรกะ (Logical Operators)", fontWeight: FontWeight.bold,),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson4/lessonImage4-4.png",
        ),
        PyoneerText.contentText("${PyoneerText.startParagraph}นอกจากนี้ยังมีตัวดำเนินการอีก 3 ประเภท คือ"),
        PyoneerText.contentText("- Bitwise Operator ตัวดำเนินการทางบิต : >> , << , & , |"),
        PyoneerText.contentText("- Python Membership Operators : in , not in"),
        PyoneerText.contentText("- Python Identity Operators: is , is not"),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ลำดับความสำคัญของเครื่องหมาย",boxAlign: Alignment.center),
        PyoneerText.contentText("(Python Operators Precedence)",boxAlign: Alignment.center),
        PyoneerText.brakeLine(),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson4/lessonImage4-5.png",
        ),


        
        PyoneerText.brakeLine(50),
      ],
    );
  }
}