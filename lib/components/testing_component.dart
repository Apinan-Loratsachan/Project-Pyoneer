import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pyoneer/utils/type_writer_text.dart';
import 'package:pyoneer/views/testings/testing1.dart';
import 'package:pyoneer/views/testings/testing2.dart';
import 'package:pyoneer/views/testings/testing3.dart';
import 'package:pyoneer/views/testings/testing4.dart';
import 'package:pyoneer/views/testings/testing5.dart';

class TestingContent {
  String proposition;
  List<String> choice;
  String correctChoice;
  String imagePath;

  TestingContent({
    required this.proposition,
    required this.choice,
    required this.correctChoice,
    required this.imagePath,
  });
}

class TestingScreen {
  static List<Widget> preTest = [
    const Testing1Screen(isPreTest: true),
    const Testing2Screen(isPreTest: true),
    const Testing3Screen(isPreTest: true),
    const Testing4Screen(isPreTest: true),
    const Testing5Screen(isPreTest: true),
  ];

  static List<Widget> postTest = [
    const Testing1Screen(isPreTest: false),
    const Testing2Screen(isPreTest: false),
    const Testing3Screen(isPreTest: false),
    const Testing4Screen(isPreTest: false),
    const Testing5Screen(isPreTest: false),
  ];
}

class Testing1 {
  static List<TestingContent> testingContent = [
    TestingContent(
      proposition: "ใครเป็นผู้พัฒนาภาษาไพธอน",
      choice: [
        "Dennis Ritchie",
        "Guido van Rossum",
        "Lady Ada",
        "James Gosling"
      ],
      correctChoice: "Guido van Rossum",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ตัวแปลภาษาไพธอนเป็นตัวแปลภาษาประเภทใด",
      choice: [
        "Compiler",
        "Script",
        "Object Oriented",
        "Interpreter"
      ],
      correctChoice: "Interpreter",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นเครื่องมือที่ใช้ในการเขียนโปรแกรมภาษาไพธอนในแบบ Online",
      choice: [
        "Notepad",
        "Colab",
        "Visual Studio Code",
        "Jupyter Notebook"
      ],
      correctChoice: "Colab",
      imagePath: '',
    ),
    TestingContent(
      proposition: "การเขียนโปรแกรมภาษาไพธอนกรณีที่ 1 บรรทัดมีหลายคำสั่งหรือหลาย Statement จะต้องคั่นแต่ละคำสั่งหรือแต่ละ Statement ด้วยสัญลักษณ์หรือเครื่องหมายในข้อใด",
      choice: [
        ": (colon)",
        ", (comma)",
        "; (semi-colon)",
        "| (pipe)"
      ],
      correctChoice: "; (semi-colon)",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ในการกำหนดขอบเขตการทำงาน (Code block) ในภาษาไพธอน ข้อใดถูกต้อง",
      choice: [
        "ใช้การย่อหน้า (indentation)",
        "ใช้วงเล็บปีกกา (curly brackets)",
        "ใช้วงเล็บก้ามปู (square brackets)",
        "ใช้วงเล็บ (parenthesis)"
      ],
      correctChoice: "ใช้การย่อหน้า (indentation)",
      imagePath: '',
    ),
    TestingContent( 
      proposition: "นามสกุลของไฟล์ภาษาไพธอน ข้อใดถูกต้อง",
      choice: [
        ".p",
        ".pl",
        ".py",
        ".python"
      ],
      correctChoice: ".py",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดไม่ใช่เครื่องหมายที่ใช้สำหรับการทำ Comment ในภาษาไพธอน",
      choice: [
        "// comment",
        "# comment",
        "\'\'\' comment \'\'\'",
        "\"\"\" comment \"\"\""
      ],
      correctChoice: "// comment",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดกล่าวไม่ถูกต้องสำหรับ Identifier ในภาษาไพธอน",
      choice: [
        "ตัวอักษรตัวเล็ก และตัวอักษรตัวใหญ่ถือเป็นคนละตัวกัน",
        "สามารถใช้ _ (under score) ขึ้นต้นเป็นตัวแรกได้",
        "สามารถมีช่องว่างได้",
        "ลงท้ายด้วยตัวเลขหรือ _ (under score) ได้"
      ],
      correctChoice: "สามารถมีช่องว่างได้",
      imagePath: '',
    ),
    TestingContent(
      proposition: "การตั้งขื่อแบบที่มีการใช้ _ (under score) ในการแยกคำ เรียกว่าเป็นการตั้งชื่อแบบใด",
      choice: [
        "Pascal Case",
        "Snake Case",
        "Camel Case",
        "Fish Case"
      ],
      correctChoice: "Snake Case",
      imagePath: '',
    ),
    TestingContent(
      proposition: "เมธอดในข้อใดใช้ในการตรวจสอบว่าเป็น identifier หรือไม่",
      choice: [
        "setidentifier( )",
        "isidentifier( )",
        "setIdentifier( )",
        "isIdentifier( )"
      ],
      correctChoice: "isidentifier( )",
      imagePath: '',
    ),
  ];
}

class Testing2 {
  static List<TestingContent> testingContent = [
    TestingContent(
      proposition: "ข้อใดไม่ใช่ Primitive Data Type ในภาษาไพธอน",
      choice: [
        "List",
        "Complex",
        "Number",
        "Boolean"
      ],
      correctChoice: "List",
      imagePath: '',
    ),
    TestingContent(
      proposition: "True และ False ถือเป็นข้อมูลประเภทใด",
      choice: [
        "List",
        "Complex",
        "Number",
        "Boolean"
      ],
      correctChoice: "Boolean",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดกล่าวไม่ถูกต้องเกี่ยวกับตัวแปร (variable)",
      choice: [
        "เป็นชื่อที่นักพัฒนาตั้งขึ้นมาเอง",
        "ต้องประกาศตัวแปร (declaration of variable) ก่อนการใช้งานทุกครั้ง",
        "การใช้งานตัวแปรเป็นการนำข้อมูลมาเก็บในตัวแปรหรือการนำข้อมูลที่อยู่ในตัวแปรไปใช้งาน",
        "ข้อมูลที่เก็บอยู่ในตัวแปรไม่สามารถเปลี่ยนค่าได้"
      ],
      correctChoice: "ข้อมูลที่เก็บอยู่ในตัวแปรไม่สามารถเปลี่ยนค่าได้",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดคือ Logical Operator ที่ใช้ในภาษาไพธอน",
      choice: [
        "+ , - , * , /",
        "! , && , ||",
        "not , and , or",
        "== , != , < , >"
      ],
      correctChoice: "not , and , or",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดให้ผลลัพธ์เป็น True",
      choice: [
        "10 + 5 * 1  > 1 * 5 + 10",
        "7 < 10 and 10 > 7",
        "5 == 5 && 55 == 55",
        "30 % 10 * 10 == 10 * 10 % 30"
      ],
      correctChoice: "7 < 10 and 10 > 7",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้ \n\t\t\tprint(8 / 4 + 5 * (3 + 1) - 7 % 4)",
      // print(8 / 4 + 5 * (3 + 1) - 7 % 4)
      choice: [
        "13.0",
        "15.0",
        "17.0",
        "19.0"
      ],
      correctChoice: "19.0",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดถูกต้องเมื่อต้องการแสดงข้อความ I'm 25 years old. ด้วยภาษาไพธอน",
      choice: [
        "print(I'm 25 years old.)",
        "print(I\\'m 25 years old.)",
        "print(\'I\'m 25 years old.\')",
        "print(\"I'm 25 years old.\")"
      ],
      correctChoice: "print(\"I'm 25 years old.\")",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ฟังก์ชันในข้อใดใช้ในการตรวจสอบชนิดข้อมูลในภาษาไพธอน",
      choice: [
        "type( )",
        "istype( )",
        "checktype( )",
        "whattype( )"
      ],
      correctChoice: "type( )",
      imagePath: '',
    ),
    TestingContent(
      proposition: "คำสั่งใดใช้ในการรับค่าข้อมูลจากผู้ใช้งานทางแป้นพิมพ์",
      choice: [
        "scanf( )",
        "read( )",
        "input( )",
        "keyboard( )"
      ],
      correctChoice: "input( )",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้",
      choice: [
        "'Love''Python''Love'",
        "'LovePythonLove'",
        "LovePythonLove",
        "Love \nPython \nLove "
      ],
      correctChoice: "'LovePythonLove'",
      imagePath: '',
    ),
  ];
}

class Testing3 {
  static List<TestingContent> testingContent = [
    TestingContent(
      proposition: "คีย์เวิร์ดใดใช้ในการนิยามฟังก์ชัน",
      choice: [
        "func",
        "function",
        "def",
        "definition"
      ],
      correctChoice: "def",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อมูลที่ส่งให้กับ parameter เรียกว่าอะไร",
      choice: [
        "variable",
        "value",
        "construtor",
        "argument"
      ],
      correctChoice: "argument",
      imagePath: '',
    ),
    TestingContent(
      proposition: "สิ่งใดใช้บ่งบอกขอบเขตการทำงานของฟังก์ชัน",
      choice: [
        "ย่อหน้า (indentation)",
        "วงเล็บปีกกา { } (curly brackets)",
        "เครื่องหมาย : (semi-colon)",
        "คำสั่ง return"
      ],
      correctChoice: "ย่อหน้า (indentation)",
      imagePath: '',
    ),
    TestingContent(
      proposition: "จำนวนข้อมูลในการส่งค่ากลับ (return value) ในภาษาไพธอนมีได้จำนวนทั้งหมดกี่ข้อมูล",
      choice: [
        "1 ข้อมูล",
        "2 ข้อมูล",
        "3 ข้อมูล",
        "ไม่จำกัด"
      ],
      correctChoice: "ไม่จำกัด",
      imagePath: '',
    ),
    TestingContent(
      proposition: "นิยามฟังก์ชันในข้อใดถูกต้อง",
      choice: [
        "def fund(data1 = 10, data2 = 20, data3) : \n\t\t\t\t\t\t\tpass ",
        "def func(data1 = 10; data2 = 20; data3) : \n\t\t\t\t\t\t\tpass ",
        "def func(data1, data2 = 10, data3 = 20) : \n\t\t\t\t\t\t\tpass ",
        "def func(data1; data2 = 10; data3 = 20) : \n\t\t\t\t\t\t\tpass "
      ],
      correctChoice: "def func(data1, data2 = 10, data3 = 20) : \n\t\t\t\t\t\t\tpass ",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(1)",
      // ข้อ 6 มีรูป
      choice: [
        "1000",
        "100",
        "10",
        "10 * 10 * 10"
      ],
      correctChoice: "1000",
      imagePath: 'assets/images/lesson3/test3-6.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(2)",
      //ข้อ 7 มีรูป
      choice: [
        "live and share",
        "Live and share",
        "Live And Share",
        "LIVE AND SHARE"
      ],
      correctChoice: "Live and share",
      imagePath: 'assets/images/lesson3/test3-7.png',
    ),
    TestingContent(
      proposition: "ฟังก์ชันประเภทใดเป็นการเรียกใช้งานฟังก์ชันตัวเอง",
      choice: [
        "Repeat Function",
        "Recursive Function",
        "Rewrite Function",
        "Reload Function"
      ],
      correctChoice: "Recursive Function",
      imagePath: '',
    ),
    TestingContent(
      proposition: "เมื่อต้องการอ้างถึงตัวแปรที่อยู่นอกฟังก์ชัน และต้องการเปลี่ยนค่าในตัวแปรนั้น ให้ระบุคีย์เวิร์ดใดที่ตัวแปรที่ต้องการใช้นั้น",
      choice: [
        "local",
        "global",
        "def",
        "function"
      ],
      correctChoice: "global",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(3)",
      //ข้อ 10 มีรูป
      choice: [
        "1 3",
        "2 3",
        "3 3",
        "Error"
      ],
      correctChoice: "3 3",
      imagePath: 'assets/images/lesson3/test3-10.png',
    ),
  ];
}

class Testing4 {
  static List<TestingContent> testingContent = [
    TestingContent(
      proposition: "คำสั่งในข้อใดเหมาะสมกับการจัดการโพรเซสการทำงานของโปรแกรมมีมากกว่า 1 เงื่อนไข ",
      choice: [
        "if statement",
        "if-else statement",
        "if-elif statement",
        "while statement"
      ],
      correctChoice: "if-elif statement",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(1)",
      // ข้อ2 มีรูป
      choice: [
        "200",
        "50",
        "70",
        "x"
      ],
      correctChoice: "200",
      imagePath: 'assets/images/lesson4/test4-2.png',
    ),
    TestingContent(
      proposition: "ข้อใดถูกต้องสำหรับ else statement ในภาษาไพธอน",
      choice: [
        "else { }",
        "else :",
        "else [ ]",
        "else ->"
      ],
      correctChoice: "else :",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(2)",
      //ข้อ 4 มีรูป
      choice: [
        "True 8",
        "False 8",
        "True",
        "False"
      ],
      correctChoice: "True 8",
      imagePath: 'assets/images/lesson4/test4-4.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(3)",
      //ข้อ 5 มีรูป
      choice: [
        "2",
        "5",
        "25",
        "32"
      ],
      correctChoice: "25",
      imagePath: 'assets/images/lesson4/test4-5.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(4)",
      //ข้อ 6 มีรูป
      choice: [
        "true",
        "false",
        "not true",
        "not false"
      ],
      correctChoice: "not false",
      imagePath: 'assets/images/lesson4/test4-6.png',
    ),
    TestingContent(
      proposition: "ผลจากการพิสูจน์เงื่อนไข (condition) ของคำสั่ง if เป็นค่าใดได้บ้าง",
      choice: [
        "boolean",
        "number",
        "string",
        "list"
      ],
      correctChoice: "boolean",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(5)",
      //ข้อ 8 มีรูป
      choice: [
        "1",
        "2",
        "3",
        "4"
      ],
      correctChoice: "3",
      imagePath: 'assets/images/lesson4/test4-8.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(6)",
      //ข้อ 9 มีรูป
      choice: [
        "1 2",
        "1 3",
        "3",
        "1 2 3"
      ],
      correctChoice: "1 2 3",
      imagePath: 'assets/images/lesson4/test4-9.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(7)",
      //ข้อ 10 มีรูป
      choice: [
        "False",
        "True",
        "1",
        "0"
      ],
      correctChoice: "False",
      imagePath: 'assets/images/lesson4/test4-10.png',
    ),
  ];
}

class Testing5 {
  static List<TestingContent> testingContent = [
    TestingContent(
      proposition: "จากโค้ดคำสั่งต่อไปนี้ จะมีการวนทำซ้ำคำสั่ง print('Python') กี่รอบ",
      //ข้อ 1 มีรูป
      choice: [
        "1 รอบ",
        "2 รอบ",
        "3 รอบ",
        "4 รอบ"
      ],
      correctChoice: "4 รอบ",
      imagePath: 'assets/images/lesson5/test5-1.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(1)",
      //ข้อ 2 มีรูป
      choice: [
        "1 6 11 16 21",
        "1 5 10 15 20 25",
        "1 5 25",
        "1 25 5"
      ],
      correctChoice: "1 6 11 16 21",
      imagePath: 'assets/images/lesson5/test5-2.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(2)",
      //ข้อ 3 มีรูป
      choice: [
        "Hi",
        "Hi Hi",
        "ไม่แสดงผลข้อมูลใดๆ",
        "Error"
      ],
      correctChoice: "ไม่แสดงผลข้อมูลใดๆ",
      imagePath: 'assets/images/lesson5/test5-3.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(3)",
      //ข้อ 4 มีรูป
      choice: [
        "1",
        "1 2",
        "1 2 3",
        "1 2 3 4"
      ],
      correctChoice: "1 2 3 4",
      imagePath: 'assets/images/lesson5/test5-4.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(4)",
      //ข้อ 5 มีรูป
      choice: [
        "0 1 2 3",
        "0 1 2",
        "0 1",
        "0"
      ],
      correctChoice: "0 1 2",
      imagePath: 'assets/images/lesson5/test5-5.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(5)",
      //ข้อ 6 มีรูป
      choice: [
        "0",
        "0 1 2 3 4 5",
        "W e l c o m e",
        "Error"
      ],
      correctChoice: "Error",
      imagePath: 'assets/images/lesson5/test5-6.png',
    ),
    TestingContent(
      proposition: "ผลจากการพิสูจน์เงื่อนไข (condition) ของคำสั่ง if เป็นค่าใดได้บ้าง",
      //ข้อ 7 มีรูป
      choice: [
        "1 2 4",
        "1 2 3 4",
        "1 2",
        "1 2 3"
      ],
      correctChoice: "1 2 4",
      imagePath: 'assets/images/lesson5/test5-7.png',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(6)",
      //ข้อ 8 มีรูป
      choice: [
        "2 2 4",
        "2 4 6",
        "2 4 8",
        "2 4 6 8"
      ],
      correctChoice: "2 4 6",
      imagePath: 'assets/images/lesson5/test5-8.png',
    ),
    TestingContent(
      proposition: "ข้อใดถูกต้องในการเขียน syntax ของ while statement",
      choice: [
        "while condition :",
        "while (condition)",
        "while [condition] :",
        "while condition do :"
      ],
      correctChoice: "while condition :",
      imagePath: '',
    ),
    TestingContent(
      proposition: "ข้อใดเป็นผลลัพธ์ที่ได้จากการทำงานของโค้ดคำสั่งภาษาไพธอนต่อไปนี้(7)",
      //ข้อ 10 มีรูป
      choice: [
        "0 1 2",
        "pass",
        "Done",
        "Error"
      ],
      correctChoice: "Done",
      imagePath: 'assets/images/lesson5/test5-10.png',
    ),
  ];
}

class TestingComponent {
  static AppBar testingAppbar(
      String title, String subTitleText, BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const SizedBox(width: 0),
          Hero(
            tag: "hero-title",
            child: Image.asset(
              "assets/icons/pyoneer_snake.png",
              fit: BoxFit.cover,
              height: 60,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TypeWriterText(
                    text: title,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TypeWriterText(
                    text: subTitleText,
                    cursorSpeed: 700,
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      toolbarHeight: 70,
    );
  }

  static Future<bool> testingBackAlert(context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // backgroundColor: Colors.white,
        // surfaceTintColor: Colors.white,
        title: const Text('ยืนยันการออกจากบททดสอบ?'),
        content: RichText(
          text: TextSpan(
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
                fontFamily: 'Noto Sans Thai'),
            children: <TextSpan>[
              TextSpan(
                text: 'คุณสามารถออกจากหน้านี้ได้อย่าง',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const TextSpan(
                text: 'ปลอดภัย',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              TextSpan(
                text: ' คำตอบของคุณจะถูก',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const TextSpan(
                text: 'บันทึก',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              TextSpan(
                text: 'ไว้และคุณสามารถกลับมา',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const TextSpan(
                text: 'ทำต่อได้',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              TextSpan(
                text: 'ทุกเมื่อ!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'ทำบททดสอบต่อ',
              style: TextStyle(
                  // color: Colors.black,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            },
            child: const Text('ออกจากบททดสอบ',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  static Widget challengeImage(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            var screenSize = MediaQuery.of(context).size;

            var width = screenSize.width;
            var height = screenSize.height;

            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: PhotoView(
                      imageProvider: NetworkImage(
                        imagePath,
                      ),
                      minScale: PhotoViewComputedScale.contained * 1,
                      maxScale: PhotoViewComputedScale.covered * 4.0,
                      initialScale: PhotoViewComputedScale.contained,
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      basePosition: Alignment.center,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Image.network(
        imagePath,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Text(
            'ไม่พบรูปภาพ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              decoration: TextDecoration.lineThrough,
            ),
          );
        },
      ),
    );
  }
}
