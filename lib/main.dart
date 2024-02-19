import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pyoneer/service/firebase_options.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/views/home.dart';
import 'package:pyoneer/views/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await UserData.loadUserData();

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
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatefulWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Noto Sans Thai',
      ),
      debugShowCheckedModeBanner: false,
      home: widget.initialScreen,
    );
  }
}
