import 'package:flutter/material.dart';
import 'package:pyoneer/utils/animation.dart';
import 'package:pyoneer/views/menu/challenge/challenge.dart';

class ChallengeGuideScreen extends StatefulWidget {
  const ChallengeGuideScreen({super.key});

  @override
  State<ChallengeGuideScreen> createState() => _ChallengeGuideScreenState();
}

class _ChallengeGuideScreenState extends State<ChallengeGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("คำอธิบาย Challenge"),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () {
                PyoneerAnimation.changeScreen(context, const ChallengeScreen());
              },
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(const Size(double.infinity, 50)),
              ),
              child: const Text("เริ่ม Challenge"),
            ),
          ),
          const SizedBox(height: 50)
        ],
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "คำอธิบาย",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Challenge เป็นการทดสอบความรู้และแข่งขันกับผู้ใช้คนอื่น จะเป็นการสุ่มคำถามจำนวน 30 ข้อและมีการจับเวลา",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 30),
                Text(
                  "เกณฑ์การจัดอันดับ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "จะจัดอันดับตามคะแนนหากคะแนนเท่ากันจะใช้เวลาในการตัดสิน",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 30),
                Text(
                  "การออกระหว่างทำ Challenge",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "การกดย้อนกลับจะมี Popup ยืนยันโดยในระหว่างที่แสดง Popup เวลาจะไม่หยุดนับ คุณสามารถออกได้ตลอดเวลาแต่แบบทดสอบที่คุณทำจะไม่ถูกบันทึก",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 30),
                Text(
                  "การทำซ้ำ Challenge",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "แบบทดสอบสามารถทำได้ตลอด โดยในการทำแต่ละครั้งจะมีการสุ่มคำถามใหม่ทั้งหมด ระบบจะบันทึกคะแนนที่สูงที่สุดของคุณ",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
