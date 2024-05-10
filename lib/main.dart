import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pyoneer/services/auth.dart';
import 'package:pyoneer/services/firebase_options.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/views/home.dart';
import 'package:pyoneer/views/login.dart';
import 'package:pyoneer/utils/offline_warning_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    bool hasUserData = await UserData.hasData();
    if (hasUserData) {
      await UserData.loadUserData();
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(currentUser.email).update({
        'uid': currentUser.uid,
        'email': currentUser.email,
        'displayName': currentUser.displayName,
        'photoURL': currentUser.photoURL,
      });
    } else {
      await UserData.clear();
      await Auth.signOut();
      currentUser = null;
    }
  }

  Widget initialScreen =
      currentUser != null ? const HomeScreen() : const LoginScreen();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatefulWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isOffline = false;
  @override
  void initState() {
    super.initState();
    // StreamSubscription<List<ConnectivityResult>> _connectivitySubscription =
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      setState(() {
        _isOffline =
            results.every((result) => result == ConnectivityResult.none);
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Noto Sans Thai',
        brightness: Brightness.light,
        colorSchemeSeed: AppColor.primarSnakeColor,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Noto Sans Thai',
        brightness: Brightness.dark,
        colorSchemeSeed: AppColor.primarSnakeColor,
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          final isDarkMode =
              MediaQuery.of(context).platformBrightness == Brightness.dark;
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  isDarkMode ? Brightness.light : Brightness.dark,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness:
                  isDarkMode ? Brightness.light : Brightness.dark,
            ),
          );
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  isDarkMode ? Brightness.light : Brightness.dark,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness:
                  isDarkMode ? Brightness.light : Brightness.dark,
            ),
            child: _isOffline
                ? const OfflineWarningScreen()
                : widget.initialScreen,
          );
        },
      ),
    );
  }
}
