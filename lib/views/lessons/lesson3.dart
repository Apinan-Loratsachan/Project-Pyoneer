import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';
import 'package:pyoneer/utils/text.dart';
import 'package:pyoneer/models/lesson_model.dart';

class Lesson3Screen extends StatefulWidget {
  const Lesson3Screen({super.key});

  @override
  State<Lesson3Screen> createState() => _Lesson3ScreenState();
}

class _Lesson3ScreenState extends State<Lesson3Screen> {
  @override
  Widget build(BuildContext context) {
    return LessonScreenModel(
      index: 3,
      lessonTitle: "ชนิดของข้อมูล",
      contentWidgets: [
        PyoneerText.contentText("ชนิดข้อมูล (Data type)",fontWeight: FontWeight.bold, fontSize: 20,),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("ชนิดข้อมูลสำหรับการเขียนโปรแกรมเบื้องต้นที่ควรรู้จักมีดังนี้", tabSpace: true),
        PyoneerText.contentText("int", fontWeight: FontWeight.bold),
        PyoneerText.spanLine(35),
        PyoneerText.contentText("เลขจำนวนเต็ม เช่น 2 , 50 ,1017",tabSpace: true),
        PyoneerText.contentText("float", fontWeight: FontWeight.bold),
        PyoneerText.spanLine(20),
        PyoneerText.contentText("เลขจำนวนจริงหรือทศนิยม เช่น 15.20, -63.9",tabSpace: true),
        PyoneerText.contentText("boolean", fontWeight: FontWeight.bold,),
        PyoneerText.contentText("บูลีน : คือค่า จริง,เท็จ ในภาษาไพทอน ใช้คำว่า True, False ในการเปรียบเทียบ จะได้ผลลัพท์เป็นบูลีน\nเช่น 4 > 1 เป็นจริง ผลที่ได้คือ บูลีน True ${PyoneerText.startParagraph}\t-8 > 7.4 เป็นเท็จ ผลที่ได้คือ บูลีน False \nเมื่อเขียนโปรแกรม เราจะใช้ผลการเปรียบเทียบ เพื่อตรวจสอบเงื่อนไขในการทำงาน", tabSpace: true),
        PyoneerText.contentText("string", fontWeight: FontWeight.bold,),
        PyoneerText.contentText("สตริงหรือข้อความ คือ ตัวอักษรที่เรียงต่อกันในเครื่องหมายคำพูด ภาษาไพทอนใช้ได้ทั้ง ' (single) , \" (double) , ''' หรือ \"\"\" (triple)", tabSpace: true),
        PyoneerText.brakeLine(10),
        Row(
          children: [
            PyoneerText.contentText("",tabSpace: true),
            PyoneerText.contentText("ตัวอย่าง",textDecoration: TextDecoration.underline),
            PyoneerText.contentText(" สตริง เช่น"),
          ],
        ),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("text1 = 'word’"),
        PyoneerText.contentText("text2 = \"This is a sentence.\" "),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("และสามารถใช้ triple ('''  หรือ  \"\"\") เพื่อกำหนดข้อความที่มีหลายบรรทัดได้ เช่น",tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("text3 = \"\"\"This is a paragraph. It is "),
        PyoneerText.contentText("\t\t\t\t\t\t\t\tmade up of",tabSpace: true),
        PyoneerText.contentText("\t\t\t\t\t\t\t\tmultiple lines and sentences.\"\"\"",tabSpace: true),
        PyoneerText.contentText("${PyoneerText.startParagraph}สตริงยังสามารถใช้ร่วมกับตัวดำเนินการ + (นำสตริงหรือข้อความมาต่อกัน) และ * (ทำซ้ำ) ได้"),
        PyoneerText.contentText("${PyoneerText.startParagraph}นอกจากนี้ยังมี ซับสตริง  (substring) หรือข้อความย่อยในสตริง เราจะใช้เครื่องหมาย  [ ] หรือ [ : ] เพื่อทำงานกับข้อความย่อย การจัดเก็บตัวอักษรแต่ละตัวจะเริ่มต้นที่ 0 จบที่ end-1 การจัดเก็บสตริงจึงอธิบายได้ดังนี้"),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson3/lessonImage3-1.png",
        ),
        PyoneerText.contentText("${PyoneerText.startParagraph}จากภาพ ตัวอย่างข้อความ Hello world! มีทั้งหมด 12 ตัวอักษร การจัดเก็บจะเริ่มที่ตำแหน่ง 0 ซึ่งเก็บตัวอักษร  H ดังนั้นตัวสุดท้าย คือ ! จะอยู่ที่ตำแหน่ง end-1 = 12 (ตำแหน่งตัวอักษรสุดท้าย) -1 = 11"),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("ตัวอย่างการทำงานกับสตริง", textDecoration: TextDecoration.underline,boxAlign: Alignment.center),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson3/lessonImage3-2.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("list", fontWeight: FontWeight.bold,),
        PyoneerText.contentText("ลิสต์ เป็นชนิดข้อมูลที่มี item หรือสมาชิก อยู่ใน list สามารถมีชนิดข้อมูลที่แตกต่างกันได้ แต่ต้องอยู่ในเครื่องหมาย [ ] แต่ละ ลิสต์ แยกกันด้วยเครื่องหมาย , (comma) สามารถเรียกมาใช้งานได้ด้วยเครื่องหมาย [ ] หรือ [ : ] item หรือสมาชิก เริ่มที่ 0 จบที่ end-1", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("ตัวอย่าง", textDecoration: TextDecoration.underline),
        PyoneerText.contentText("myList= [‘Hello’ , ’my’ , ‘student’] ",tabSpace: true),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson3/lessonImage3-3.png",
        ),
        PyoneerText.contentText("จากตัวอย่าง จะเห็นว่าจำนวน item หรือขนาด ของ list คือ 3 แต่ item แรกเริ่มต้นอยู่ที่ตำแหน่ง 0 item สุดท้ายอยู่ที่ตำแหน่ง 2 คือ end-1 (3-1=2) นั่นเอง",tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("ตัวอย่างการทำงานกับลิสต์", textDecoration: TextDecoration.underline,boxAlign: Alignment.center),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson3/lessonImage3-4.png",
        ),


        PyoneerText.brakeLine(50),
      ],
    );
  }
}
