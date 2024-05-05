import 'package:flutter/material.dart';

class PyoneerAnimation {
  static int changeScreenDuration = 750;
  static Cubic changeScreenCurve = Curves.easeInOutQuart;

  static int pageviewChangeScreenDuration = 750;
  static Cubic pageviewChangeScreenCurve = Curves.easeInOutQuart;

  static Future<dynamic> changeScreen(BuildContext context, Widget targetScreen,
      {double beginX = 0.0, double beginY = 1.0}) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => targetScreen,
        transitionDuration: Duration(milliseconds: changeScreenDuration),
        transitionsBuilder: (context, animation1, animation2, child) {
          animation1 = CurvedAnimation(
            parent: animation1,
            curve: changeScreenCurve,
          );
          return FadeTransition(
            opacity: Tween(
              begin: 0.0,
              end: 1.0,
            ).animate(animation1),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(beginX, beginY),
                end: Offset.zero,
              ).animate(animation1),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
