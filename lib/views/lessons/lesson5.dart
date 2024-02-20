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
      lessonTitle: "คำสั่งรับค่า\nและ การแสดงผล",
      contentWidgets: [
        PyoneerText.contentText(
            "การทำงานเพื่อติดต่อกับผู้ใช้ เราสามารถเรียกใช้ฟังก์ชั่นเพื่อรับ หรือแสดงผลลักษณะของฟังก์ชั่น คือ คำสั่งหลายๆ คำสั่ง ที่สร้างไว้แล้ว เราสามารถเรียกใช้ได้แต่ต้องเป็นไปตามรูปแบบที่กำหนด ในส่วนนี้ เพื่อรับและแสดงผล เราจะศึกษาดังนี้",
            tabSpace: true),
        PyoneerText.contentText("คำสั่งแสดงผล ใช้ฟังก์ชั่น print()",
            tabSpace: true),
        PyoneerText.contentText("คำสั่งรับข้อมูล ใช้ฟังก์ชั่น input()",
            tabSpace: true),
        PyoneerText.brakeLine(),
        PyoneerText.contentText(
          "คำสั่งการแสดงผล",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        PyoneerText.contentText(
            "ใช้ฟังก์ชั่น print() เพื่อแสดงผลที่จอภาพ ในเครื่องหมาย () จะส่งข้อมูล : ตัวแปร, ข้อความ เพื่อแสดงผลที่จอภาพ ข้อมูลแยกด้วยเครื่องหมาย ,",
            tabSpace: true),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson5/lessonImage5-1.png",
        ),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText(
            "นอกจากนี้ หากเราต้องการแสดงผล การขึ้นบรรทัดใหม่ ใช้ \"\\n\"",
            tabSpace: true),
        PyoneerText.brakeLine(20),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่าง",
                textDecoration: TextDecoration.underline),
          ],
        ),
        LessonComponent.lessonImage(
            context, "assets/images/lesson5/lessonImage5-2.png"),
        PyoneerText.brakeLine(10),
        PyoneerText.divider(50),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText(
          "คำสั่งรับข้อมูล",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        PyoneerText.contentText(
            "ใช้ฟังก์ชั่น input() จะรอรับข้อมูลจากผู้ใช้ ดังนั้นเราต้องพิมพ์ข้อมูลเข้าผ่านทางคีย์บอร์ด ปกติเราใส่ข้อมูล 1 ตัว (เช่น ตัวเลข หรือ ข้อความ) แล้วเคาะ enter ข้อมูลที่เราพิมพ์นั้นจะเป็น string (function return string) เราต้องสร้างตัวแปร เพื่อเก็บข้อมูลดังกล่าว",
            tabSpace: true),
        PyoneerText.brakeLine(10),
        Row(
          children: [
            PyoneerText.contentText("", tabSpace: true),
            PyoneerText.contentText("ตัวอย่าง",
                textDecoration: TextDecoration.underline),
            PyoneerText.contentText(" เช่น"),
          ],
        ),
        PyoneerText.brakeLine(5),
        PyoneerText.contentText("test = input(\"Enter your input: \")",
            tabSpace: true),
        PyoneerText.contentText("print (\"Received input is : \", test)",
            tabSpace: true),
        PyoneerText.brakeLine(5),
        PyoneerText.contentText(
            "หากผู้ใช้พิมพ์ข้อความ Hello Python ตัวอย่างการทำงานและผลลัพธ์ จะได้ดังนี้",
            tabSpace: true),
        PyoneerText.brakeLine(5),
        PyoneerText.contentText("Enter your input : Hello Python",
            tabSpace: true),
        PyoneerText.contentText("Received input is : Hello Python",
            tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText(
            "จากตัวอย่าง ข้อความ Hello Python ที่เราพิมพ์ จะถูกเก็บไว้ที่ตัวแปร test ทำให้เห็นว่า ฟังก์ชั่น input จะรอผู้ใช้พิมพ์ข้อมูลจากคีย์บอร์ด ซึ่งข้อมูลที่รับมานั้นจะเป็น สตริง นำไปคำนวณไม่ได้ถึงแม้เราจะพิมพ์ตัวเลขก็ตาม หากเราต้องการนำไปคำนวณ เราต้องแปลงสตริงเป็นตัวเลขที่ต้องการ เช่น แปลงจาก string เป็น int หรือ แปลงจาก string เป็น float",
            tabSpace: true),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
            context, "assets/images/lesson5/lessonImage5-3.png"),
        PyoneerText.brakeLine(15),
        PyoneerText.contentText("อธิบายได้ ดังนี้", tabSpace: true),
        PyoneerText.contentText(
            "บรรทัดที่ 1 จะปรากฏข้อความ Input integer number ที่จอภาพ เคอร์เซอร์กระพริบ รอให้ผู้ใช้พิมพ์ สมมติว่าผู้ใช้	พิมพ์ 55 เคาะ enter ผลที่ได้ คือ string 55 จะถูกเก็บที่ตัวแปร inp1",
            tabSpace: true),
        PyoneerText.contentText(
            "บรรทัดที่ 2 จะแปลง string 55 ซึ่งเก็บี่ตัวแปร inp1 ให้เป็นตัวเลขจำนวนเต็มเก็บไว้ที่ตัวแปร no1 จากนี้เราสามารถ นำ no1 ไปคำนวณได้",
            tabSpace: true),
        PyoneerText.contentText(
            "บรรทัดที่ 3 และ 4 ก็เช่นเดียวกันกับบรรทัดที่ 1 และ 2 เพียงแต่แปลง จาก string เป็น float ",
            tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("ข้อควรระวัง ",textDecoration: TextDecoration.underline, fontWeight: FontWeight.bold),
        PyoneerText.contentText("เราต้องทราบว่าโปรแกรมเรามีข้อมูลอะไรที่เข้ามาบ้างเพื่อที่ว่าเราจะได้ออกแบบชนิดข้อมูลและนำไปเขียนโปรแกรมได้อย่างถูกต้อง เช่น", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("inp=input(\"Input number : \")",
            tabSpace: true),
        PyoneerText.contentText("no=int(inp)", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText(
            "เมื่อโปรแกรมทำงาน หากเราใส่ 1.2 เก็บที่ตัวแปร โปรแกรมจะทำการเก็บข้อมูลที่เราป้อนเป็นแบบ string ในขั้นตอนนี้จะยังไม่มีปัญหาอะไร แต่ปัญหาจะเกิดขึ้นตอนที่เราเรียกใช้งาน ซึ่งในที่นี้เราเรียกใช้งานแบบ int จึงทำให้เกิด error",
            tabSpace: true),
        PyoneerText.brakeLine(50),
      ],
    );
  }
}
