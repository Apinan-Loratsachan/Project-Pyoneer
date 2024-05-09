import 'package:flutter/material.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/utils/text.dart';
import 'package:pyoneer/models/lesson_model.dart';

class Lesson1Screen extends StatefulWidget {
  const Lesson1Screen({super.key});

  @override
  State<Lesson1Screen> createState() => _Lesson1ScreenState();
}

class _Lesson1ScreenState extends State<Lesson1Screen> {
  @override
  Widget build(BuildContext context) {
    return LessonScreenModel(
      index: 1,
      lessonTitle: "Python Interpreter and Tool​",
      youtubeVideoID: "eWRfhZUzrAc",
      contentWidgets: [
        PyoneerText.contentText("Tools for Python Programming",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.contentText("(เครื่องมือสำหรับเขียนไพท่อน)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.contentText("${PyoneerText.startParagraph}เครื่องมือในการเขียนภาษาไพท่อนสามารถติดตั้งได้ 2 แบบคือ"),
        PyoneerText.contentText("ติดตั้งในเครื่องผู้พัฒนา (On Local)", tabSpace: true,fontWeight: FontWeight.bold),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ติดตั้ง Python Interpreter โดย download ได้ที่ https://www.python.org/​​", tabSpace: true),
        PyoneerText.contentText("**แนะนำให้ติดตั้ง python 3​"),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-1.png",
        ),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-2.png",
        ),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-3.png",
        ),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-4.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("การตรวจสอบ Python ว่าติดตั้งในเครื่องของผู้พัฒนาหรือไม่ ผ่าน Command Line ด้วยคำสั่ง python -V​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-5.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("สามารถทดสอบการเขียนโปรแกรมภาษา Python ผ่านหน้าจอ Command Prompt/Terminal​"),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-6.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("หรือผ่าน IDEL Shell (ติดตั้งมาพร้อมกับตอนการติดตั้ง Python Interpeter)​"),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-7.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ผ่าน Code Editor Tool : Visual Studio Code download ได้ที่ ​https://code.visualstudio.com/​"),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-8.png",
        ),LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-9.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ผ่าน IDE Tool : JupyterNotebook download ได้ที่ ​https://www.anaconda.com/download​"),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-10.png",
        ),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-11.png",
        ),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-12.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ใช้งานผ่าน Internet ด้วย Browser (On Cloud)", tabSpace: true,fontWeight: FontWeight.bold),
        PyoneerText.contentText("โดยใช้เครื่องมือที่ชื่อว่า Google Colaboratory : Google Colab เป็นเครื่องมือสำหรับเขียนโปรแกรมด้วยภาษา Python ใช้งานผ่าน Cloud โดยไม่ต้องติดตั้ง เพียงแค่ต่อ Internet และแนะนำให้ก่อนเข้าใช้งาน Sign in ผ่าน Google account​ ทำการประมวลผลได้ทั้งบน CPU และ GPU ​Free ​ข้อควรระวัง อาจมีการหลุดการเชื่อมต่อในทุก 30 นาที หากไม่ได้ใช้งาน​", tabSpace: true),
        PyoneerText.contentText("*ข้อควรระวัง อาจมีการหลุดการเชื่อมต่อในทุก 30 นาที หากไม่ได้ใช้งาน​", tabSpace: true),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("การเข้าใช้งาน Google Colab​", tabSpace: true,fontWeight: FontWeight.bold),
        PyoneerText.contentText("ให้ทำการ Sign in - Google Account​ โดยไปที่ https://colab.research.google.com/​ จะมีหน้าต่างดังรูปด้านล่าง โดยจะแนะนำการใช้งานเบื้องต้นดังต่อไปนี้", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-13.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ปรับ Theme ให้ไปที่เมนู Tools -> Setting หรือคลิกที่ ​รูปฟันเฟือง​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-14.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ปรับฟอนต์ (font) ย่อหน้า (indent) และการใส่หมายเลขกำกับบรรทัด (line number)​​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-15.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("การสร้าง Notebook ใหม่เพื่อเขียนโปรแกรม​ ไปที่เมนู File แล้วเลือก New notebook​​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-16.png",
        ),
        PyoneerText.contentText("เพื่อเปิดแล้วจะได้ Notebook ใหม่ดังรูป​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-17.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("ส่วนของชื่อไฟล์ สามารถตั้งชื่อใดๆ ก็ได้ แต่นามสกุลจะเป็น .inpynb​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-18.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("+ Code เป็นปุ่มใช้สำหรับเพิ่ม Code Cell ที่ใช้สำหรับการเขียนโค้ดภาษา Python​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-19.png",
        ),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-20.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("+ Text เป็นปุ่มใช้สำหรับเพิ่ม Text Cell ที่ใช้สำหรับเขียนข้อความต่างๆ เช่น คำอธิบายโค้ด จนโน๊ตต่างๆ แต่ต้องเขียนเป็น Markdown (เป็น Lightweight Markup Language ที่ใช้สำหรับจัด Format ของ Plain Text บน Document และแปลงเป็น HTML เพื่อแสดงผลเป็นเว็บผ่าน Browser)​​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-21.png",
        ),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-22.png",
        ),
        PyoneerText.brakeLine(),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-23.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("สำหรับ Code Cell ทำการ Run เพื่อแสดงผลการทำงานมี 4 วิธีหลักๆ ดังนี้​", tabSpace: true),
        PyoneerText.contentText("- Alt+Enter จะเป็นการรันและมีการสร้าง Code Cell ขึ้นมาใหม่ทุกครั้ง​"),
        PyoneerText.contentText("- Shift+Enter จะเป็นการรัน และไปยัง Code Cell ถัดไป แต่หากไม่มี Code Code ถัดไป จะมีการสร้าง Code Cell ขึ้นมาใหม่​​"),
        PyoneerText.contentText("- Ctrl+Enter (แนะนำ) จะเป็นการรันและยังอยู่ที่ Cell เดิมที่ทำการรัน​​"),
        PyoneerText.contentText("- คลิกที่สัญลักษณ์​​"),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-24.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("Clear output​ สามารถล้างหรือลบผลลัพธ์จากการรันของ Code Cell โดยคลิกที่ ​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-25.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("Statements (การเขียนคำสั่ง)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.contentText("Single-line statement​", tabSpace: true),
        PyoneerText.contentText("Python โดยปกติจะเขียน 1 บรรทัด 1 คำสั่ง หรือ 1 statement​และจะปิดท้ายด้วยเครื่องหมาย ; (semi-colon) หรือไม่ก็ได้​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-26.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("Multi-line statement​", tabSpace: true),
        PyoneerText.contentText("กรณี statement ยาวเกิน 1 บรรทัดจะใช้  line continuation character  ( \\ ) เพื่อเป็นการเชื่อมต่อ statement​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-27.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("กรณีเป็นการคำนวณที่อยู่ภายใต้ (  ) หรือ การใช้ [  ] สำหรับ List หรือ {  } สร้าง Dictionay ก็สามารถมีหลายบรรทัดได้โดยไม่ต้องใช้ line continuation character ( \\ ) ​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-28.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("กรณีที่ต้องการมีหลาย statement อยู่บรรทัดเดียวกัน ให้แต่ละ statement ที่อยู่บรรทัดเดียวกันปิดท้ายด้วยเครื่องหมาย  ; ยกเว้น statement สุดท้ายของบรรทัดนั้นไม่จำเป็นต้องปิดท้ายด้วยเครื่องหมาย ;​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-29.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("Indentation (การเยื้องย่อหน้า)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.contentText("สำหรับ Python เราจะใช้ย่อหน้า (Indentation) ในการกำหนดขอบเขตการทำงานของกลุ่มโค้ดหนึ่งๆ (A code block) เช่น function, condition, loop, class, method, …​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-30.png",
        ),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-31.png",
        ),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-32.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("Comment (การแสดงว่าคิดเห็น)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.contentText("เป็นข้อความที่เขียนแทรกเข้าไปในโค้ดคำสั่ง แต่จะไม่มีผลต่อการทำงาน โดยทั่วไปจะใช้เขียนโน๊ตอธิบายหรือหมายเหตุ เพื่อกำกับโคัคคำสั่งนั้นๆ​", tabSpace: true),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("Single-line comment​", tabSpace: true),
        PyoneerText.contentText("- เป็นการเขียนคอมเมนต์แบบบรรทัดเดียวโดยใช้สัญลักษณ์ # (เรียกเครื่องหมาย hash) นำหน้า​"),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-33.png",
        ),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("Multi-line comment​", tabSpace: true),
        PyoneerText.contentText("- เป็นการเขียนคอมเมนต์แบบหลายบรรทัดโดยใช้สัญลักษณ์ ​Single quote (') 3 ตัว '''....''' ​หรือ ​Double quote (\") 3 ตัว \"\"\".....\"\"\" ​ครอบข้อความเนื้อหาที่เป็นคอมเมนต์​"),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-34.png",
        ),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-35.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("Keyword (คำเฉพาะ)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.contentText("หรือ Reserved words เป็นคำที่ไม่สามารถหรือแนะนำให้มาใช้ในการตั้งชื่อ (Identifiers) ใดๆ  เช่น ชื่อตัวแปร ชื่อค่าคงที่ ชื่อคลาส ชื่อฟังก์ชัน ชื่อเมธอด ชื่อออปเจ็กต์   โดยใน Python มี Keywords ต่อไปนี้​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-36.png",
        ),
        PyoneerText.contentText("สามารถใช้ฟังก์ชัน iskeyword( ) จากโมดูล keyword ในการตรวจสอบว่าคำนั้นเป็น keyword หรือไม่ โดยจะให้ผลลัพธ์เป็น True กรณีที่คำนั้นเป็น keyword และให้ผลลัพธ์เป็น False กรณีที่คำนั้นไม่ใช่ keyword​", tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-37.png",
        ),
        PyoneerText.brakeLine(20),
        PyoneerText.contentText("Identifier (ตัวระบุ)",fontWeight: FontWeight.bold, fontSize: 20),
        PyoneerText.contentText("เป็นชื่อที่ถูกตั้งขึ้นในการเขียนโปรแกรม ได้แก่ ชื่อตัวแปร ชื่อฟังก์ชัน ชื่อคลาส ชื่อออปเจ็กต์ ชื่อเมธอด โดยจะต้องเป็นไปตามกฏการตั้งชื่อ ดังนี้​​", tabSpace: true),
        PyoneerText.contentText("- ชื่อต้องขึ้นต้นด้วยตัวอักษรตัวเล็ก (a-z) หรือตัวอักษรตัวใหญ่ (A-Z) หรือ _ (underscore)​"),
        PyoneerText.contentText("- ภายในชื่อสามารถประกอบด้วย ด้วยตัวอักษรตัวเล็ก (a-z) และตัวอักษรตัวใหญ่ (A-Z) และ _ (underscore) และ ตัวเลข (0-9)​"),
        PyoneerText.contentText("- ภายในชื่อต้องไม่มีอักขระพิเศษใด เช่น !, @, #, \$, % เป็นต้น​"),
        PyoneerText.contentText("- ชื่อต้องไม่ตั้งซ้ำกับ Keywords ​"),
        PyoneerText.contentText("- ห้ามมีช่องว่างระหว่างชื่อ และความยาวของชื่อมีได้ไม่จำกัด​"),
        PyoneerText.contentText("- ตัวอักษรตัวเล็กตัวใหญ่ถือว่าเป็นคนละตัวหรือคนละชื่อกัน (Case-sensitive)​"),
        PyoneerText.brakeLine(),
        PyoneerText.contentText("รูปแบบในการตั้งชื่อที่นิยมมี 2 รูปแบบหลัก คือ​​"),
        PyoneerText.contentText("แบบ Camel Case เป็นเหมือนหลังอูฐมีสูงมีต่ำ โดยใช้อักษรเล็กใหญ่ปนกัน โดยมีการขึ้นต้นด้วยอักษรตัวเล็กหรือไม่ก็ขึ้นต้นด้วยอักษรตัวใหญ่ เช่น employeeSalary, studentFinalScore​ EmployeeSalary, StudentFinalScore​​​​",tabSpace: true),
        PyoneerText.contentText("แบบ Snack Case เป็นเหมือนงูที่ขดไปขดมา โดยใช้ underscore ปนเข้าไปในชื่อ โดยจะเป็นอักษรตัวเล็กหมด เช่น ​employee_salary, student_final_score​​",tabSpace: true),
        PyoneerText.contentText("สามารถใช้เมธอด isidentifier( ) ในการตรวจสอบว่าชื่อที่ตั้งขึ้นมานั้นใช้ได้หรือไม่ กรณีที่ใช้ได้จะได้ผลลัพธ์เป็น True กรณีใช้ไม่ได้จะได้ผลลัพธ์เป็น False ​​",tabSpace: true),
        PyoneerText.contentText("*ข้อควรระวัง การใช้ฟังก์ชั้นนี้จะไม่ได้ตรวจสอบ keyword ​​",tabSpace: true),
        LessonComponent.lessonImage(//ใส่รูป
          context,
          "assets/images/lesson1/lessonImage1-38.png",
        ),


        PyoneerText.brakeLine(50),
      ],
    );
  }
}
