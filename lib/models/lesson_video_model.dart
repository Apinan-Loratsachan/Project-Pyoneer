import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/utils/duration.dart';
import 'package:pyoneer/utils/log.dart';
import 'package:pyoneer/views/home.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonVideoModel extends StatefulWidget {
  final int index;
  final String? youtubeVideoID;

  const LessonVideoModel({
    super.key,
    required this.index,
    this.youtubeVideoID,
  });

  @override
  _LessonVideoModelState createState() => _LessonVideoModelState();
}

class _LessonVideoModelState extends State<LessonVideoModel> {
  YoutubePlayerController? _youtubePlayerController;
  bool _isPlayerReady = false;

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
  }

  @override
  void dispose() {
    if (_youtubePlayerController != null) {
      _youtubePlayerController!.removeListener(() {});
      _youtubePlayerController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
            overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
      },
      onExitFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
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
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "วิดีโอประกอบ${LessonComponent.lessonContent[widget.index].title}",
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                LessonComponent.lessonContent[widget.index].subTitle,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.7)
                        : Colors.black.withOpacity(0.7)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          toolbarHeight: 80,
        ),
        body: Column(
          children: [
            AspectRatio(aspectRatio: 16 / 9, child: player).animate(
              effects: [
                const FadeEffect(
                  curve: Curves.easeInOut,
                  delay: Duration(milliseconds: 250),
                  duration: Duration(milliseconds: 1000),
                ),
                const ScaleEffect(
                  curve: Curves.easeInOut,
                  delay: Duration(milliseconds: 250),
                  duration: Duration(milliseconds: 1000),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Text(
              "VIDEO by",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ).animate(
              effects: [
                const ScaleEffect(
                  curve: Curves.easeInOut,
                  delay: Duration(milliseconds: 500),
                  duration: Duration(milliseconds: 1000),
                )
              ],
            ),
            const SizedBox(height: 20),
            Image.asset(
              "assets/icons/pyoneer_long.png",
              width: MediaQuery.of(context).size.width * 0.5,
            ).animate(
              effects: [
                const ScaleEffect(
                  curve: Curves.easeInOut,
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 1000),
                )
              ],
            ),
            const Text(
              "Copyright © 2024 PY৹NEER,\nAll right reserved",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ).animate(
              effects: [
                const ScaleEffect(
                  curve: Curves.easeInOut,
                  delay: Duration(milliseconds: 1500),
                  duration: Duration(milliseconds: 1000),
                )
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              child: const Text("กลับหน้าหลัก"),
            ).animate(
              effects: [
                const ScaleEffect(
                  curve: Curves.easeInOut,
                  delay: Duration(milliseconds: 2000),
                  duration: Duration(milliseconds: 1000),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
