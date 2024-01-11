import 'package:flutter/material.dart';
import 'package:pyoneer/utils/lesson_component.dart';
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
      appBarTitle: "Lesson 2",
      coverImagePath: "assets/images/lesson1/cover.png",
      heroTag: "lesson-2-cover",
      lessonTitle: "ตัวแปรและชนิดข้อมูล",
      contentWidgets: [
        const Text("ตัวแปร (Variable) คืออะไร",
            style: TextStyle(
              fontSize: PyoneerText.bodyTextSize,
              fontWeight: FontWeight.normal,
            )),
        const Text(
          "${PyoneerText.startParagraph}ตัวแปร (Variable) คือ ตัวที่ใช้เก็บข้อมูล โดยจะมีการกำหนดชื่อให้กับตัวแปรนั้น ๆ ซึ่งชื่อตัวแปรจะต้องไม่ซ้ำกับคำสงวน (Keyword) ของภาษาไพทอน และตัวแปรจะต้องเป็นตัวอักษรภาษาอังกฤษ ตัวเลข หรือสัญลักษณ์ _ และตัวแปรจะต้องขึ้นต้นด้วยตัวอักษรหรือสัญลักษณ์ _ เท่านั้น",
        ),
        const SizedBox(
          height: PyoneerText.bodyTextSize,
        ),
        const Text("ตัวแปร (Variable) ในภาษาไพทอน",
            style: TextStyle(
              fontSize: PyoneerText.bodyTextSize,
              fontWeight: FontWeight.normal,
            )),
        const Text(
          "${PyoneerText.startParagraph}ในภาษาไพทอน การประกาศตัวแปรจะไม่ต้องระบุชนิดข้อมูล แต่จะต้องกำหนดค่าให้กับตัวแปรนั้น ๆ ก่อน โดยการกำหนดค่าให้กับตัวแปรนั้น ๆ จะต้องมีการใช้เครื่องหมาย = ในการกำหนดค่า และเมื่อต้องการเปลี่ยนค่าตัวแปรนั้น ๆ ก็สามารถกำหนดค่าใหม่ได้เช่นกัน",
        ),
        const SizedBox(
          height: PyoneerText.bodyTextSize,
        ),
        const Text(
          "ตัวอย่างการประกาศตัวแปร",
          style: TextStyle(
            fontSize: PyoneerText.bodyTextSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        const Text(
          "${PyoneerText.startParagraph}ตัวอย่างการประกาศตัวแปรในภาษาไพทอน ดังตัวอย่างต่อไปนี้",
        ),
        LessonComponent().lessonImage(
          context,
          "assets/images/lesson1/lessonImage1.jpg",
        ),
        const SizedBox(
          height: PyoneerText.bodyTextSize,
        ),
      ],
    );
  }
}
