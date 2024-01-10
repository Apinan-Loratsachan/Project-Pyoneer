// import 'package:flutter/material.dart';
// import 'package:pyoneer/utils/lesson_component.dart';
// import 'package:pyoneer/utils/text.dart';

// class LessonScreen extends StatefulWidget {
//   final String title;
//   final String tag;
//   final String imagePath;
//   final List<Widget> contentWidgets;

//   const LessonScreen({
//     super.key,
//     required this.title,
//     required this.tag,
//     required this.imagePath,
//     required this.contentWidgets,
//   });

//   @override
//   State<LessonScreen> createState() => _LessonScreenState();
// }

// class _LessonScreenState extends State<LessonScreen> with TickerProviderStateMixin {
//   late AnimationController _fadeController;
//   late AnimationController _slideController;
//   late Animation<double> _titleFadeAnimation;
//   late Animation<Offset> _titleSlideAnimation;
//   late Animation<double> _contentFadeAnimation;
//   late Animation<Offset> _contentSlideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2000),
//     );
//     _slideController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2000),
//     );

//     _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _fadeController,
//         curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
//       ),
//     );

//     _titleSlideAnimation =
//         Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
//       CurvedAnimation(
//         parent: _slideController,
//         curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
//       ),
//     );

//     _contentFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _fadeController,
//         curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
//       ),
//     );
//     _contentSlideAnimation =
//         Tween<Offset>(begin: const Offset(0.0, 0.2), end: Offset.zero).animate(
//       CurvedAnimation(
//         parent: _slideController,
//         curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
//       ),
//     );

//     _fadeController.forward();
//     _slideController.forward();
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: LessonComponent.lessonsAppbar(widget.title),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Hero(
//                   tag: widget.tag,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20.0),
//                     child: Image.asset(widget.imagePath),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//               FadeTransition(
//                 opacity: _titleFadeAnimation,
//                 child: SlideTransition(
//                   position: _titleSlideAnimation,
//                   child: Text(
//                     widget.title,
//                     style: const TextStyle(
//                       fontSize: PyoneerText.titleTextSize,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//               FadeTransition(
//                 opacity: _contentFadeAnimation,
//                 child: SlideTransition(
//                   position: _contentSlideAnimation,
//                   child: Column(
//                     children: widget.contentWidgets,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
