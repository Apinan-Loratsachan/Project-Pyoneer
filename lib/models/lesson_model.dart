import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pyoneer/components/lesson_component.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
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
  // ignore: library_private_types_in_public_api
  _LessonScreenModelState createState() => _LessonScreenModelState();
}

class _LessonScreenModelState extends State<LessonScreenModel>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _contentFadeAnimation;
  late Animation<Offset> _contentSlideAnimation;
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
          mute: true,
          hideControls: false,
          forceHD: false,
          controlsVisibleAtStart: true,
          showLiveFullscreenButton: false,
          disableDragSeek: false,
        ),
      );
    }
    _scrollController.addListener(_scrollListener);
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _titleSlideAnimation =
        Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _contentFadeAnimation = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.25, 0.75, curve: Curves.easeOut),
      ),
    );
    _contentSlideAnimation =
        Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.25, 0.75, curve: Curves.easeIn),
      ),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _youtubePlayerController?.dispose();
    _fadeController.dispose();
    _slideController.dispose();
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

    if (kDebugMode) {
      print('currentScroll: ${currentScrollPercentage.toStringAsFixed(2)}%');
    }

    if (currentScrollPercentage > threshold) {
      if (kDebugMode) {
        print('User has scrolled more than $threshold%');
      }

      if (!lessonReadStatusChecked) {
        insertLessonReadStatus();
        lessonReadStatusChecked = true;
      }
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
        padding: const EdgeInsets.all(15.0),
        child: LessonComponent.lessonCover(
            LessonComponent.lessonContent[widget.index].imageSrc,
            LessonComponent.lessonContent[widget.index].heroTag),
      ),
      const SizedBox(height: 25),
      SlideTransition(
        position: _titleSlideAnimation,
        child: FadeTransition(
          opacity: _titleFadeAnimation,
          child: Text(
            widget.lessonTitle,
            style: const TextStyle(
              fontSize: PyoneerText.titleTextSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      const SizedBox(height: 25),
      SlideTransition(
        position: _contentSlideAnimation,
        child: FadeTransition(
          opacity: _contentFadeAnimation,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ...widget.contentWidgets,
              ],
            ),
          ),
        ),
      ),
      if (widget.youtubeVideoID != null) const SizedBox(height: 20),
      if (widget.youtubeVideoID != null)
        SlideTransition(
          position: _contentSlideAnimation,
          child: FadeTransition(
            opacity: _contentFadeAnimation,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: YoutubePlayer(
                controller: _youtubePlayerController!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: AppColor.tertiarySnakeColor,
                progressColors: const ProgressBarColors(
                  playedColor: AppColor.primarSnakeColor,
                  handleColor: AppColor.secondarySnakeColor,
                ),
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                  RemainingDuration(),
                  // FullScreenButton(),
                ],
              ),
            ),
          ),
        ),
      if (widget.youtubeVideoID != null) const SizedBox(height: 100),
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
