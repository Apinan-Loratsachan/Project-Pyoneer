import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';
import 'package:pyoneer/service/user_data.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "บทเรียน",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < LessonComponent.lessonContent.length; i++)
              lessonTitle(
                LessonComponent.lessonContent[i].imageSrc,
                LessonComponent.lessonContent[i].heroTag,
                LessonComponent.lessonContent[i].title,
                LessonComponent.lessonContent[i].subTitle,
                LessonComponent.lessonContent[i].targetScreen,
                context,
                i,
              )
          ],
        ),
      ),
    );
  }

  //-----------------------------------------------------------------------------------

  static Future<bool> checkLessonReadStatus(
      String email, int lessonIndex) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('lessons')
        .where('email', isEqualTo: email)
        .where('lessonRead', isEqualTo: lessonIndex)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  ListTile lessonTitle(String imageSrc, String heroTag, String title,
      String subtitle, Widget targetScreen, BuildContext context, int index) {
    return ListTile(
      leading: LessonComponent.lessonCover(imageSrc, heroTag, true),
      onTap: () async {
        if (UserData.email != 'ไม่ได้เข้าสู่ระบบ') {
          Map<String, dynamic> lessonData = {
            'email': UserData.email,
            'lessonRead': index,
          };

          // Navigate to the target screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          ).then((value) {
            if (value) {
              setState(() {});
            }
          });

          // Check if the data already exists in Firestore
          QuerySnapshot<Map<String, dynamic>> querySnapshot =
              await FirebaseFirestore.instance
                  .collection('lessons')
                  .where('email', isEqualTo: UserData.email)
                  .where('lessonRead', isEqualTo: index)
                  .get();

          // If there are no documents matching the query, add the data to Firestore
          if (querySnapshot.docs.isEmpty) {
            await FirebaseFirestore.instance
                .collection('lessons')
                .add(lessonData);
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        }
      },
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
      ),
      trailing: FutureBuilder<bool>(
        future: checkLessonReadStatus(UserData.email, index),
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.connectionState == ConnectionState.waiting) {
            child = const SizedBox();
          } else if (snapshot.data! != true) {
            child = const Icon(
              Icons.check_circle_rounded,
              color: Colors.transparent,
            );
          } else {
            child = const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
            );
          }
          return AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: child,
          );
        },
      ),
    );
  }
}
