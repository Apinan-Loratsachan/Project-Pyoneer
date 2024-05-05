import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/models/lesson_video_model.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/log.dart';
import 'package:pyoneer/utils/text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonScreenModel extends StatefulWidget {
  final int index;
  final String lessonTitle;
  final List<Widget> contentWidgets;
  final String? youtubeVideoID;

  const LessonScreenModel({
    super.key,
    required this.index,
    required this.lessonTitle,
    required this.contentWidgets,
    this.youtubeVideoID,
  });

  @override
  _LessonScreenModelState createState() => _LessonScreenModelState();
}

class _LessonScreenModelState extends State<LessonScreenModel>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  YoutubePlayerController? _youtubePlayerController;
  bool lessonReadStatusChecked = false;

  @override
  void initState() {
    super.initState();
    if (widget.youtubeVideoID != null) {
      _youtubePlayerController = YoutubePlayerController(
        initialVideoId: widget.youtubeVideoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          hideControls: false,
          forceHD: false,
          controlsVisibleAtStart: true,
          showLiveFullscreenButton: false,
          disableDragSeek: false,
        ),
      )..addListener(() {
          setState(() {});
        });
    }
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    if (_youtubePlayerController != null) {
      _youtubePlayerController!.removeListener(() {});
      _youtubePlayerController!.dispose();
    }
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    // double delta = 100.0;
    double threshold = 80.0;

    double currentScrollPercentage = (currentScroll / maxScroll) * 100;

    if (currentScrollPercentage > threshold) {
      // PyoneerLog.printGreen('User has scrolled more than $threshold%');
      PyoneerLog.white(
          'currentScroll: \x1B[32m${currentScrollPercentage.toStringAsFixed(2)}%\x1B[0m');

      if (!lessonReadStatusChecked) {
        insertLessonReadStatus();
        lessonReadStatusChecked = true;
      }
    } else {
      PyoneerLog.white(
          'currentScroll: \x1B[33m${currentScrollPercentage.toStringAsFixed(2)}%\x1B[0m');
    }
  }

  Future insertLessonReadStatus() async {
    if (UserData.email == 'ไม่ได้เข้าสู่ระบบ') {
      return;
    }
    if (UserData.email != 'ไม่ได้เข้าสู่ระบบ') {
      Map<String, dynamic> lessonData = {
        'email': UserData.email,
        'lessonRead': widget.index,
        'timestamp': FieldValue.serverTimestamp(),
      };
      // Check if the data already exists in Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('lessons')
              .where('email', isEqualTo: UserData.email)
              .where('lessonRead', isEqualTo: widget.index)
              .get();

      // If there are no documents matching the query, add the data to Firestore
      if (querySnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('lessons').add(lessonData);
      }
    }
  }

  // void _scrollDown() {
  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeIn,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    List<Widget> allWidgets = [
      Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: LessonComponent.lessonCover(
            LessonComponent.lessonContent[widget.index].imageSrc,
            LessonComponent.lessonContent[widget.index].heroTag),
      ),
      const SizedBox(height: 25),
      Text(
        widget.lessonTitle,
        style: const TextStyle(
          fontSize: PyoneerText.titleTextSize,
        ),
        textAlign: TextAlign.center,
      )
          .animate()
          .slide(
              begin: const Offset(0.1, 0),
              duration: 1500.ms,
              curve: Curves.easeInOutCubic)
          .fade(duration: 1500.ms, curve: Curves.easeInOutCubic),
      const SizedBox(height: 25),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ...widget.contentWidgets,
          ],
        ),
      )
          .animate()
          .slide(
              begin: const Offset(0.1, 0),
              duration: 1600.ms,
              curve: Curves.easeInOutCubic)
          .fade(duration: 1600.ms, curve: Curves.easeInOutCubic),
      if (widget.youtubeVideoID != null)
        Column(
          children: [
            PyoneerText.divider(MediaQuery.of(context).size.width * 0.1),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "วิดีโอประกอบการเรียน",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonVideoModel(
                          index: widget.index,
                          youtubeVideoID: widget.youtubeVideoID,
                        ),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow),
                      SizedBox(
                        width: 5,
                      ),
                      Text("ดูวิดีโอ"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
            .animate()
            .slide(
                begin: const Offset(0.1, 0),
                delay: 500.ms,
                duration: 1500.ms,
                curve: Curves.easeInOutCubic)
            .fade(
                duration: 1500.ms, delay: 500.ms, curve: Curves.easeInOutCubic),
      const SizedBox(
        height: 20,
      ),
      PyoneerText.divider(MediaQuery.of(context).size.width * 0.1),
      const SizedBox(
        height: 40,
      ),
    ];

    return Scaffold(
      appBar: LessonComponent.lessonsAppbar(
          LessonComponent.lessonContent[widget.index].title,
          LessonComponent.lessonContent[widget.index].subTitle,
          context),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _scrollDown,
      //   child: const Icon(Icons.arrow_downward),
      // ),
      body: Scrollbar(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: Column(
              children: allWidgets,
            ),
          ),
        ),
      ),
    );
  }
}
