import 'package:flutter/material.dart';
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
      index: 2,
      lessonTitle: "Primitive Data   Types, ​Variables, Expressions, Type Conversions, Input",
      youtubeVideoID: "HGOBQPFzWKo",
      contentWidgets: [
        PyoneerText.contentText("Data Types (ชนิดข้อมูล)",fontWeight: FontWeight.bold, fontSize: 20,),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("ทุกค่าข้อมูลในไพธอนมีประเภทหรือชนิดของข้อมูล เรียกว่า Data Types ", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("ชนิดข้อมูลพื้นฐานในไพธอน", textDecoration: TextDecoration.underline, boxAlign: Alignment.center),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("1. Python String คือ ชนิดข้อมูลประเภทข้อความ (String) เช่น ‘สมชาย’  “sombat”  ...​"),
        PyoneerText.contentText("2. Python Number คือ ข้อมูลชนิดตัวเลข​"),
        PyoneerText.contentText("​- ชนิดข้อมูลประเภทเลขจำนวนเต็ม (Integer number) เช่น  10  999  ...", tabSpace: true),
        PyoneerText.contentText("- ชนิดข้อมูลประเภทเลขจำนวนจริง (Float/Real number) เช่น 56.148  87.00 ...​", tabSpace: true),
        PyoneerText.contentText("- ชนิดข้อมูลประเภทจำนวนเชิงซ้อน (Complex) เช่น 20 + 9j ...​​", tabSpace: true),
        PyoneerText.contentText("3. Python Boolean คือ ชนิดข้อมูลประเภทตรรกะ (Boolean) มีค่าเป็นแค่ True หรือ False เท่านั้น​​​"),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("ใน Python สามารถตรวจสอบชนิดข้อมูลได้ด้วยฟังก์ชัน type( )​", tabSpace: true),
        PyoneerText.brakeLine(),
        PyoneerText.divider(50),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("Variable (ตัวแปร)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.contentText("${PyoneerText.startParagraph}Variable (ตัวแปร) เป็นชื่อที่ถูกตั้งขึ้นเพื่อใช้ในการเก็บค่าข้อมูล (value) ที่เกิดขึ้นในโปรแกรม เพื่ออ้างอิงไปยังหน่วยความจำที่ใช้ในการเก็บข้อมูลนั้นๆ​​"),
        PyoneerText.contentText("${PyoneerText.startParagraph}​ชื่อตัวแปรควรตั้งให้สื่อความหมายตามกฏการตั้งชื่อ (identifier) เช่น sumNumber เก็บผลรวม emp_salary เก็บเงินเดือน mid_score เก็บคะแนนกลางภาค หรือ empName เก็บชื่อพนักงาน เป็นต้น​"),
        PyoneerText.contentText("${PyoneerText.startParagraph}ค่​าข้อมูลที่เก็บอยู่ในตัวแปรเป็นได้หลากหลายชนิดข้อมูลและสามารถเปลี่ยนแปลงได้​ การเก็บค่าข้อมูลในตัวแปรอาจจะมาจากการกำหนดค่าด้วยตัวดำเนินการกำหนดค่า การป้อน การเรียกใช้งานฟังก์ชัน หรืออื่นๆ ​​"),
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
        PyoneerText.brakeLine(),
        PyoneerText.contentText("********* ใส่รูปเพิ่ม ********************"),
        PyoneerText.brakeLine(),
        PyoneerText.divider(50),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("Expression (นิพจน์)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("Expression (นิพจน์) เป็นการนำค่าคงที่ ข้อมูล ตัวแปร หรือตัวดำเนินการต่างๆ มาเขียนประกอบกัน เพื่อประมวลผลใดๆ เช่น", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("นิพจน์ทางคณิตศาสตร์ a+b*10+(3*c)*8", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("นิพจน์เชิงตรรกะหรือนิพจน์เชิงเปรียบเทียบความสัมพันธ์ (m>=n) and (x<y)​", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("นิพจน์เชิงตรรกะหรือนิพจน์เชิงเปรียบเทียบความสัมพันธ์ not (k==25)", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("นิพจน์เชิงตรรกะ not (p)", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("นิพจน์เชิงตรรกะและนิพจน์เชิงเปรียบเทียบ (i>10) or (j<5)​", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("นิพจน์เงื่อนไข if  (y==z)", tabSpace: true),
        PyoneerText.brakeLine(),
        PyoneerText.divider(50),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("Type Conversion \n(ประเภทของการแปลงชนิดข้อมูล)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("1.  Implicit Type Conversion​ เป็นการแปลงชนิดข้อมูลหนึ่งไปเป็นอีกชนิดข้อมูลหนึ่งโดยอัตโนมัติ โดยที่ไม่ต้องทำอะไร​"),
        PyoneerText.contentText("********* ใส่รูปเพิ่ม ********************"),
        PyoneerText.contentText("2.   Explicit Type Conversion​เป็นการแปลงชนิดข้อมูลโดยการใช้คำสั่งต่างๆ ในการแปลงข้อมูล เช่น int(), float(), str()​​"),
        PyoneerText.contentText("********* ใส่รูปเพิ่ม ********************"),
        PyoneerText.brakeLine(),
        PyoneerText.divider(50),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("Input (การรับข้อมูล)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("การรับข้อมูลใดๆ ใน Python จากผู้ใช้งาน User จะใช้ฟังก์ชัน input( [prompt] ) ​โดย prompt คือข้อความที่แสดงเพื่อสื่อความหมายบอกผู้ใช้ว่าต้องป้อนอะไร​", tabSpace: true),
        PyoneerText.contentText("ข้อมูลที่ป้อนจะถือเป็นข้อความ string ​กรณีที่ต้องการนำข้อมูลที่ป้อนไปใช้ยังส่วนต่างๆ ในโค้ด ควรมีตัวแปรมาเก็บสิ่งที่ป้อน​กรณีต้องการนำข้อมูลที่ป้อนไปคำนวณจะต้องทำการแปลงชนิดข้อมูล (Type casting) เป็นตัวเลขเสียก่อน​", tabSpace: true),
        PyoneerText.contentText("********* ใส่รูปเพิ่ม ********************"),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("*** มีการแปลงชนิดข้อมูลตอนนำไปใช้งาน", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("********* ใส่รูปเพิ่ม ********************"),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("*** มีการแปลงชนิดข้อมูลตอนรับค่าข้อมูลจากผู้ใช้", tabSpace: true),
        PyoneerText.brakeLine(10),
        PyoneerText.contentText("การรับข้อมูลหลายข้อมูลโดยใช้ฟังก์ชัน input( ) เดียวด้วยเมธอด split( ) โดยต้องเว้นวรรคแต่ละข้อมูลที่ป้อน", tabSpace: true),
        PyoneerText.contentText("********* ใส่รูปเพิ่ม ********************"),
        
        
        
        PyoneerText.brakeLine(50),
        

      ],
    );
  }
}
