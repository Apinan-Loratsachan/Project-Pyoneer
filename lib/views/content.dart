import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              LessonComponent.lessonTitle(
                LessonComponent.lessonContent[i].imageSrc,
                LessonComponent.lessonContent[i].heroTag,
                LessonComponent.lessonContent[i].title,
                LessonComponent.lessonContent[i].subTitle,
                LessonComponent.lessonContent[i].targetScreen,
                context,
              )
          ],
        ),
      ),
    );
  }
}
