import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_model.dart';
import 'package:pyoneer/utils/lesson_component.dart';
import 'package:pyoneer/utils/text.dart';

class Lesson3Screen extends StatelessWidget {
  const Lesson3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonScreenModel(
      appBarTitle: 'Lesson 3',
      coverImagePath: 'assets/images/lesson1/cover.png',
      heroTag: "lesson-3-cover",
      lessonTitle: "Lesson 3",
      contentWidgets: [
        const Text(
          "ตัวแปร (Variable) คืออะไร",
          style: TextStyle(
            fontSize: PyoneerText.bodyTextSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(
          height: PyoneerText.textSpaceSize,
        ),
        const Text(
          "ตัวแปร (Variable) คือ ตัวที่ใช้เก็บข้อมูล โดยจะมีการกำหนดชื่อให้กับตัวแปรนั้น ๆ ซึ่งชื่อตัวแปรจะต้องไม่ซ้ำกับคำสงวน (Keyword) ของภาษาไพทอน และตัวแปรจะต้องเป็นตัวอักษรภาษาอังกฤษ ตัวเลข หรือสัญลักษณ์ _ และตัวแปรจะต้องขึ้นต้นด้วยตัวอักษรหรือสัญลักษณ์ _ เท่านั้น",
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "ตัวแปร (Variable) ในภาษาไพทอน",
          style: TextStyle(
            fontSize: PyoneerText.bodyTextSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(
          height: PyoneerText.textSpaceSize,
        ),
        const Text(
          "ในภาษาไพทอน การประกาศตัวแปรจะไม่ต้องระบุชนิดข้อมูล แต่จะต้องกำหนดค่าให้กับตัวแปรนั้น ๆ ก่อน โดยการกำหนดค่าให้กับตัวแปรนั้น ๆ จะต้องมีการใช้เครื่องหมาย = ในการกำหนดค่า และเมื่อต้องการเปลี่ยนค่าตัวแปรนั้น ๆ ก็สามารถกำหนดค่าใหม่ได้เช่นกัน",
        ),
        LessonComponent().lessonImage(
          context,
          "assets/images/lesson1/lessonImage1.jpg",
        ),
      ],
    );
  }
}
