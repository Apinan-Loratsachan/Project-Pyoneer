import 'package:flutter/material.dart';
import 'package:pyoneer/components/lesson_component.dart';
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
      lessonTitle: "Function",
      youtubeVideoID: "8DvywoWv6fI",
      contentWidgets: [
        PyoneerText.contentText("Function (ฟังก์ชั่น)",fontWeight: FontWeight.bold, fontSize: 20,),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("Function คือ การทำงานเฉพาะหนึ่งๆ ซึ่งโปรแกรมที่ดีไม่ควรเขียนโค้ดคำสั่งการทำงานทุกอย่างกองไว้ที่เดียวกัน ควรแยกการทำงานแต่ละอย่างหรือแต่ละส่วนออกมาจากกันเป็นฟังก์ชัน มีทั้งแบบที่มากับภาษาโปรแกรมเรียก Build-in Function และ แบบนักพัฒนาเขียนเองเรียก User-Defind Function​​​", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("คุณสมบัติของ Function", fontWeight: FontWeight.bold),
        PyoneerText.contentText("- Function จะไม่ทำงานหากไม่มีการเรียกใช้ (call function)​",tabSpace: true),
        PyoneerText.contentText("- Function หนึ่งๆ จะถูกเรียกใช้งานกี่ครั้ง ที่ไหน และเมื่อใดก็ได้ในโค้ดโปรแกรม​",tabSpace: true),
        PyoneerText.contentText("- Function จะมีการทำงาน คำสั่งเฉพาะ ของแต่ละฟังก์ชั่น ทำให้ตัวโค้ดมีรูปแบบที่ง่ายต่อการดู การแก้ไข การปรับปรุง เปลี่ยนแปลง เพิ่มเติมของการทำงานต่างๆ​​​",tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("รูปแบบไวยกรณ์ของตัวฟังก์ชัน (Syntax of Function)​", fontWeight: FontWeight.bold),
        PyoneerText.contentText("รูปแบบไวยกรณ์ของตัวฟังก์ชัน"),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("def  function_name( parameters ) :", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          statement(s)", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("การเรียกใช้ฟังก์ชันให้ทำงาน"),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("function_name( arguments )​", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.brakeLine(10),
        Row(
          children: [
            PyoneerText.contentText("ความหมาย",textDecoration: TextDecoration.underline),
            PyoneerText.contentText(" คือ"),
          ],
        ),
        PyoneerText.brakeLine(10),
        Row(
          children: [
            PyoneerText.contentText("def ", fontWeight: FontWeight.bold),
            PyoneerText.contentText(" เป็นคีย์เวิร์ดที่บ่งบอกถึงการสร้างตัวฟังก์ชัน"),
          ],
        ),
        Row(
          children: [
            PyoneerText.contentText("statement ", fontWeight: FontWeight.bold),
            PyoneerText.contentText(" มีได้มากกว่า 1 และทุกๆ statement"),
          ],
        ),
        PyoneerText.contentText("ของฟังก์ชันต้องมีย่อหน้า (indent) เป็นการบอกถึงขอบเขต (scope) การทำงานของฟังก์ชัน"),
        Row(
          children: [
            PyoneerText.contentText("parameters", fontWeight: FontWeight.bold),
            PyoneerText.contentText(" คือ ตัวแปร (Variable in the"),
          ],
        ),
        PyoneerText.contentText("declaration of function) ที่ใช้ได้เฉพาะในฟังก์ชันนั้นๆ เท่านั้น"),
        Row(
          children: [
            PyoneerText.contentText("arguments", fontWeight: FontWeight.bold),
            PyoneerText.contentText(" คือ ค่าจริงๆ (Actual Value) ที่ส่งไปให้"),
          ],
        ),
        PyoneerText.contentText("กับ parameter เพื่อนำไปใช้ในฟังก์ชันนั้นๆ เท่านั้น"),
        PyoneerText.brakeLine(15),
        PyoneerText.contentText("ลักษณะของ Function", fontWeight: FontWeight.bold),
        PyoneerText.contentText("มีอยู่ 2 ลักษณะใหญ่ แบ่งเป็น 4 แบบย่อย​", tabSpace: true),
        PyoneerText.contentText("1. แบบที่เมื่อถูกเรียกใช้แล้วไม่มีการส่งค่ากลับ (no return) แยกเป็น ​"),
        PyoneerText.contentText("- ไม่มีพารามิเตร์ (no parameter)​​", tabSpace: true),
        PyoneerText.contentText("- มีพารามิเตร์ (have parameter)​​", tabSpace: true),
        PyoneerText.contentText("2. แบบเมื่อถูกเรียกใช้แล้วมีการส่งค่ากลับ (have returns) ไปยังจุดเรียกใช้ฟังก์ชัน แยกเป็น ​​"),
        PyoneerText.contentText("- ไม่มีพารามิเตร์ (no parameter)​​", tabSpace: true),
        PyoneerText.contentText("- มีพารามิเตร์ (have parameter)​​", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("1.1) Function – No Parameter/No Return ​​"),
        PyoneerText.contentText("เป็นรูปแบบของฟังก์ชันที่ไม่มี parameters ในวงเล็บของ function_name และไม่มีคำสั่ง return ใน statements การเรียกใช้ฟังก์ชัน (call function) จะเขียนขึ้นโดดๆ​", tabSpace: true),
        PyoneerText.contentText("​รูปแบบไวยกรณ์ของตัวฟังก์ชัน", tabSpace: true),
        PyoneerText.contentText("def  function_name( ) :", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          statement", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          statement", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          ...", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          ..", tabSpace: true, fontWeight: FontWeight.bold),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson3/lessonImage3-3.png",
        ),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("1.2) Function – Have Parameters/No Return​​"),
        PyoneerText.contentText("เป็นรูปแบบของฟังก์ชันที่มีพารามิเตอร์ในวงเล็บของ function_name และไม่มีคำสั่ง return ใน statements การเรียกใช้ฟังก์ชัน (call function) จะเขียนขึ้นโดดๆ และมีการส่งอาร์กิวเมนต์ไปให้พารามิเตอร์​", tabSpace: true),
        PyoneerText.contentText("​รูปแบบไวยกรณ์ของตัวฟังก์ชัน", tabSpace: true),
        PyoneerText.contentText("def  function_name( parameters ) :", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          statement", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          statement", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          ...", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          ..", tabSpace: true, fontWeight: FontWeight.bold),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson3/lessonImage3-3.png",
        ),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("2.1) Function – No Parameter/Have Returns​"),
        PyoneerText.contentText("เป็นรูปแบบของฟังก์ชันที่ไม่มีพารามิเตอร์ในวงเล็บของ function_name แต่มีคำสั่ง return ใน statements การเรียกใช้งานฟังก์ชัน (call function) ควรที่จะมีการเรียกใช้จากส่วนที่มีการนำค่าที่ส่งกลับมาจากการเรียกใช้ฟังก์ชันไปใช้งาน ซึ่งมักจะไม่นิยมเขียนโดดๆ ​", tabSpace: true),
        PyoneerText.contentText("​รูปแบบไวยกรณ์ของตัวฟังก์ชัน", tabSpace: true),
        PyoneerText.contentText("def  function_name( ) :", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          statement", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          statement", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          ...", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          ..", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          return value(s)", tabSpace: true, fontWeight: FontWeight.bold),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson3/lessonImage3-3.png",
        ),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("2.2) Function – Have Parameters/Have Returns​"),
        PyoneerText.contentText("เป็นรูปแบบของฟังก์ชันที่มีพารามิเตอร์ในวงเล็บของ function_name และมีคำสั่ง return ใน statements การเรียกใช้งานฟังก์ชัน (call function) ควรที่จะมีการเรียกใช้จากส่วนที่มีการนำค่าที่ส่งกลับมาจากการเรียกใช้ฟังก์ชันไปใช้งาน ซึ่งมักจะไม่นิยมเขียนโดดๆ และมีการส่งอาร์กิวเมนต์ไปให้พารามิเตอร์ ​", tabSpace: true),
        PyoneerText.contentText("​รูปแบบไวยกรณ์ของตัวฟังก์ชัน", tabSpace: true),
        PyoneerText.contentText("def  function_name( parameters ) :", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          statement", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          statement", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          ...", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          ..", tabSpace: true, fontWeight: FontWeight.bold),
        PyoneerText.contentText("          return value(s)", tabSpace: true, fontWeight: FontWeight.bold),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson3/lessonImage3-3.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("ตัวอย่างการตั้งค่า Default Arguments", textDecoration: TextDecoration.underline,boxAlign: Alignment.center),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson3/lessonImage3-3.png",
        ),
        PyoneerText.contentText("ในที่นี้ 0 คือ default argument กรณีที่ไม่มีการส่งค่า argument มาให้พารามิเตอร์กับ your_age ค่าของพารามิเตอร์ your_age จะมีค่าเป็น 0​", tabSpace: true),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("ตัวอย่างกรณี Return not values", textDecoration: TextDecoration.underline,boxAlign: Alignment.center),
        PyoneerText.brakeLine(10),
        LessonComponent.lessonImage(
          context,
          "assets/images/lesson3/lessonImage3-3.png",
        ),
        PyoneerText.contentText("คำสั่ง return ที่ไม่มี values ต่อท้าย เมื่อทำงานจะ เปรียบเสมือนเป็นการบอกว่าสิ้นสุดการทำงานของฟังก์ชันนั้นๆ โดยจะไม่ทำงานคำสั่งที่เหลือใดๆ​", tabSpace: true),
        

        PyoneerText.brakeLine(50),
      ],
    );
  }
}
