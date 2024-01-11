import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pyoneer/firebase_options.dart';
import 'package:pyoneer/views/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime? lastPressedTime;

  Future<bool> onWillPop() async {
    final DateTime now = DateTime.now();
    final bool backButton = lastPressedTime == null ||
        now.difference(lastPressedTime!) > const Duration(seconds: 2);

    if (backButton) {
      lastPressedTime = now;
      Fluttertoast.showToast(
        msg: "Double tap to exit app",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return false; // false will do nothing when back button is pressed
    }

    return true; // true will exit the app
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Noto Sans Thai',
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}
