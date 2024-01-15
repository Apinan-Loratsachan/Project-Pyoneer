import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';
import 'package:pyoneer/models/lesson_model.dart';
import 'package:pyoneer/utils/text.dart';

class Lesson0Screen extends StatefulWidget {
  const Lesson0Screen({super.key});

  @override
  State<Lesson0Screen> createState() => _Lesson0ScreenState();
}

class _Lesson0ScreenState extends State<Lesson0Screen> {
  @override
  Widget build(BuildContext context) {
    return LessonScreenModel(
      appBarTitle: LessonComponent.lessonTitle[0],
      appBarSubTitle: LessonComponent.lessonSubTitle[0],
      coverImagePath: LessonComponent.lessonImageSrc[0],
      heroTag: LessonComponent.heroTag[0],
      lessonTitle: "Python คืออะไร",
      contentWidgets: [
        PyoneerText.contentText(
            tabSpace: true, "Python เป็นภาษาโปรแกรมมิ่งที่มีความสามารถสูงและใช้งานง่าย ซึ่งมักจะถูกใช้ในหลากหลายโครงการทางด้านเทคโนโลยี รวมถึงการพัฒนาเว็บไซต์, การวิเคราะห์ข้อมูล, การเรียนรู้ของเครื่องจักร (machine learning), และการพัฒนาแอปพลิเคชันต่างๆ หนึ่งในคุณสมบัติที่ทำให้ Python โดดเด่นคือมันมี syntax ที่อ่านง่ายและเข้าใจง่าย ซึ่งช่วยให้โปรแกรมเมอร์ทั้งมือใหม่และมืออาชีพสามารถเขียนโปรแกรมได้โดยไม่มีความซับซ้อนที่ไม่จำเป็นPython ยังสนับสนุนหลักการของการเขียนโปรแกรมแบบวัตถุนิยม (Object-Oriented Programming - OOP) ซึ่งเป็นรูปแบบการเขียนโปรแกรมที่ช่วยให้โค้ดมีความเป็นระเบียบและง่ายต่อการจัดการ นอกจากนี้ Python ยังมีชุมชนผู้ใช้ขนาดใหญ่และไลบรารีต่างๆ มากมายที่พร้อมใช้งาน ซึ่งทำให้การพัฒนาโปรแกรมด้วย Python สามารถทำได้ง่ายและรวดเร็ว ไม่ว่าจะเป็นโครงการขนาดเล็กหรือขนาดใหญ่ก็ตาม ด้วยเหตุผลเหล่านี้ Python จึงเป็นหนึ่งในภาษาโปรแกรมมิ่งที่ได้รับความนิยมอย่างสูงในหมู่นักพัฒนาและนักวิจัยทั่วโลก และยังคงเติบโตในการใช้งานอย่างกว้างขวางในอนาคต."),
      ],
    );
  }
}
