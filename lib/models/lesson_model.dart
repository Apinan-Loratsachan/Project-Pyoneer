import 'package:flutter/material.dart';
import 'package:pyoneer/models/lesson_component.dart';
import 'package:pyoneer/utils/text.dart';

class LessonScreenModel extends StatefulWidget {
  final String appBarTitle;
  final String appBarSubTitle;
  final String coverImagePath;
  final String heroTag;
  final String lessonTitle;
  final List<Widget> contentWidgets;

  const LessonScreenModel({
    super.key,
    required this.appBarTitle,
    required this.appBarSubTitle,
    required this.coverImagePath,
    required this.heroTag,
    required this.lessonTitle,
    required this.contentWidgets,
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

  @override
  void initState() {
    super.initState();
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
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LessonComponent.lessonsAppbar(
          widget.appBarTitle, widget.appBarSubTitle, context),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: LessonComponent.lessonCover(
                      widget.coverImagePath, widget.heroTag),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
