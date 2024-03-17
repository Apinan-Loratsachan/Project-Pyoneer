import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/utils/duration.dart';
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
  bool _isPlayerReady = false;
  double? _lastScrollPosition;
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
    ];

    return widget.youtubeVideoID != null
        ? YoutubePlayerBuilder(
            onEnterFullScreen: () {
              if (_scrollController.hasClients) {
                _lastScrollPosition = _scrollController.offset;
              }
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
                  overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
            },
            onExitFullScreen: () {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients &&
                    _lastScrollPosition != null) {
                  _scrollController.jumpTo(_lastScrollPosition!);
                }
              });
            },
            player: YoutubePlayer(
              controller: _youtubePlayerController!,
              topActions: [
                Text(
                  "${LessonComponent.lessonContent[widget.index].title} ${LessonComponent.lessonContent[widget.index].subTitle}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
              aspectRatio: MediaQuery.of(context).size.height /
                  MediaQuery.of(context).size.width,
              thumbnail: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/pyoneer_text.png",
                        height: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Text(LessonComponent.lessonContent[widget.index].subTitle)
                    ],
                  )),
              onReady: () {
                _isPlayerReady = true;
                PyoneerLog.green(
                    "Video Player โหลดเสร็จแล้ว (${_isPlayerReady.toString()})");
              },
              onEnded: (metaData) async {
                _youtubePlayerController
                    ?.load(_youtubePlayerController!.initialVideoId);
                await Future.delayed(const Duration(milliseconds: 300));
                _youtubePlayerController?.pause();
              },
              bottomActions: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                CurrentPosition(
                  controller: _youtubePlayerController,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                ProgressBar(
                  isExpanded: true,
                  colors: const ProgressBarColors(
                      playedColor: Colors.white,
                      backgroundColor: Colors.white12,
                      bufferedColor: Colors.white38,
                      handleColor: AppColor.primarSnakeColor),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                RemainingDuration(),
                Text(
                  " / ${PyoneeyDuration.durationFormatter(_youtubePlayerController!.metadata.duration.inMilliseconds)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                FullScreenButton(),
              ],
            ),
            builder: (context, player) => Scaffold(
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
                      children: [
                        Column(
                          children: allWidgets,
                        ),
                        if (widget.youtubeVideoID != null)
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: Column(
                              children: [
                                PyoneerText.divider(0),
                                const SizedBox(height: 40),
                                Text(
                                  "วิดีโอประกอบการเรียน ${LessonComponent.lessonContent[widget.index].title}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  LessonComponent
                                      .lessonContent[widget.index].subTitle,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: player,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                const Text(
                                  "VIDEO by",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Image.asset(
                                  "assets/icons/pyoneer_long.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                                const Text(
                                  "Copyright © 2024 PY৹NEER,\nAll right reserved",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 50),
                              ],
                            ),
                          )
                              .animate()
                              .slide(
                                begin: const Offset(0.1, 0),
                                duration: 1500.ms,
                              )
                              .fade(
                                duration: 1500.ms,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
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
