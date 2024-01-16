import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pyoneer/service/firebase_options.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/views/home.dart';
import 'package:pyoneer/views/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await UserData.loadUserData();
  // print('User uid loaded: ${UserData.uid}');
  // print('User username loaded: ${UserData.userName}');
  // print('User email loaded: ${UserData.email}');
  // print('User image loaded: ${UserData.image}');

  // Check if user is logged in
  Widget initialScreen = const LoginScreen();
  if (FirebaseAuth.instance.currentUser != null) {
    initialScreen = const HomeScreen();
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatefulWidget {
  final Widget initialScreen;
  const MyApp({Key? key, required this.initialScreen}) : super(key: key);

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
        home: widget.initialScreen,
      ),
    );
  }
}
