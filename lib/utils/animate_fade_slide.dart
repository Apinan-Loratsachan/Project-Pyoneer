import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension AnimateFadeSlide on Widget {
  Widget animateFadeSlide(
      {Duration duration = const Duration(milliseconds: 1500),
      Offset begin = const Offset(0.0, 1.0)}) {
    return animate(onPlay: (controller) => controller.forward())
        .fade(duration: duration)
        .slide(begin: begin, duration: duration);
  }
}

extension AnimateSlideFade on Widget {
  Widget animateSlideFade(
      {Duration duration = const Duration(milliseconds: 1500),
      Offset begin = const Offset(0.1, 0)}) {
    return animate(onPlay: (controller) => controller.forward())
        .slide(begin: begin, duration: duration)
        .fade(duration: duration);
  }
}
