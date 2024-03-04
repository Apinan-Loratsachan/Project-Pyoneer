import 'package:flutter/material.dart';
import 'package:pyoneer/utils/type_writer_text.dart';

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

class Testing1 {
  static List<TestingContent> testingContent = [
    TestingContent(
      proposition: "proposition1",
      choice: [
        "proposition1 choice1",
        "proposition1 choice2",
        "proposition1 choice3",
        "proposition1 choice4"
      ],
      correctChoice: "proposition1 choice1",
      imagePath: 'assets/icons/pyoneer_snake.png',
    ),
    TestingContent(
      proposition: "proposition2",
      choice: [
        "proposition2 choice1",
        "proposition2 choice2",
        "proposition2 choice3",
        "proposition2 choice4"
      ],
      correctChoice: "proposition2 choice4",
      imagePath: '',
    ),
    TestingContent(
      proposition: "proposition3",
      choice: [
        "proposition3 choice1",
        "proposition3 choice2",
        "proposition3 choice3",
        "proposition3 choice4"
      ],
      correctChoice: "proposition3 choice3",
      imagePath: '',
    ),
    TestingContent(
      proposition: "proposition4",
      choice: [
        "proposition4 choice1",
        "proposition4 choice2",
        "proposition4 choice3",
        "proposition4 choice4"
      ],
      correctChoice: "proposition4 choice2",
      imagePath: '',
    ),
    TestingContent(
      proposition: "proposition5",
      choice: [
        "proposition5 choice1",
        "proposition5 choice2",
        "proposition5 choice3",
        "proposition5 choice4"
      ],
      correctChoice: "proposition5 choice1",
      imagePath: '',
    ),
  ];
}

class Testing2 {
  static List<TestingContent> testingContent = [
    TestingContent(
      proposition: "จากรูปต่อไปนี้ขัอใดถูกต้อง",
      choice: [
        "proposition1 choice1",
        "proposition1 choice2",
        "proposition1 choice3",
        "proposition1 choice4"
      ],
      correctChoice: "proposition1 choice1",
      imagePath: 'assets/icons/pyoneer_snake.png',
    ),
    TestingContent(
      proposition: "proposition2",
      choice: [
        "proposition2 choice1",
        "proposition2 choice2",
        "proposition2 choice3",
        "proposition2 choice4"
      ],
      correctChoice: "proposition2 choice4",
      imagePath: '',
    ),
    TestingContent(
      proposition: "proposition3",
      choice: [
        "proposition3 choice1",
        "proposition3 choice2",
        "proposition3 choice3",
        "proposition3 choice4"
      ],
      correctChoice: "proposition3 choice3",
      imagePath: '',
    ),
    TestingContent(
      proposition: "proposition4",
      choice: [
        "proposition4 choice1",
        "proposition4 choice2",
        "proposition4 choice3",
        "proposition4 choice4"
      ],
      correctChoice: "proposition4 choice2",
      imagePath: '',
    ),
    TestingContent(
      proposition: "proposition5",
      choice: [
        "proposition5 choice1",
        "proposition5 choice2",
        "proposition5 choice3",
        "proposition5 choice4"
      ],
      correctChoice: "proposition5 choice1",
      imagePath: '',
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
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('ยืนยันการออกจากบททดสอบ?'),
        content: RichText(
          text: const TextSpan(
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Noto Sans Thai'),
            children: <TextSpan>[
              TextSpan(
                text:
                    'คุณสามารถออกจากหน้านี้ได้อย่างปลอดภัย คำตอบของคุณจะถูกบันทึกไว้และ',
                // style: TextStyle(fontSize: 16),
              ),
              TextSpan(
                text: 'คุณสามารถกลับมาทำต่อได้ทุกเมื่อ!',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('ยกเลิก', style: TextStyle(color: Colors.black)),
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
}
