import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static String uid = "";
  static String userName = "";
  static String email = "";
  static String image = "";
  static String tel = "";
  static String accountType = "";
  static bool showProfile = true;
  static int loginType = 0;

  static ValueNotifier<String> imageNotifier = ValueNotifier<String>("");

  static Future<void> updateUserImage(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('image', imageUrl);
    image = imageUrl;
    imageNotifier.value = imageUrl;
  }

  static Future<void> saveUserData(
      UserCredential userCredential, String accountType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', userCredential.user?.uid ?? "");
    await prefs.setString('userName', userCredential.user?.displayName ?? "");
    await prefs.setString('email', userCredential.user?.email ?? "");
    await prefs.setString('image', userCredential.user?.photoURL ?? "");
    await prefs.setString('tel', userCredential.user?.phoneNumber ?? "");
    await prefs.setString('accountType', accountType);

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentReference userRef = users.doc(userCredential.user?.email);

    bool exists = (await userRef.get()).exists;

    if (exists) {
      await userRef.update({
        'uid': userCredential.user?.uid,
        'email': userCredential.user?.email,
        'displayName': userCredential.user?.displayName,
        'photoURL': userCredential.user?.photoURL,
      });
    } else {
      await userRef.set({
        'uid': userCredential.user?.uid,
        'email': userCredential.user?.email,
        'displayName': userCredential.user?.displayName,
        'photoURL': userCredential.user?.photoURL,
      });
    }
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    uid = "";
    userName = "";
    email = "";
    image = "";
    imageNotifier.value = "";
    tel = "";
    accountType = "";
    showProfile = true;
  }

  static Future<bool> hasData() async {
    final prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid') ?? '';
    String accountType = prefs.getString('accountType') ?? '';
    return uid.isNotEmpty && accountType.isNotEmpty;
  }

  static Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? "";
    userName = prefs.getString('userName') ?? "";
    email = prefs.getString('email') ?? "";
    image = prefs.getString('image') ?? "";
    tel = prefs.getString('tel') ?? "";
    accountType = prefs.getString('accountType') ?? "";

    if (image.isNotEmpty) {
      imageNotifier.value = image;
    }
  }

  static Widget loginProvider(String imagePath) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(imagePath),
        ),
        Text(accountType)
      ],
    );
  }

  static Widget getLoginProviderIcon() {
    if (accountType == 'ไม่ระบุตัวตน') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(FontAwesomeIcons.userSecret),
          ),
          Text(accountType),
        ],
      );
    } else if (accountType == 'Google') {
      return loginProvider("assets/icons/google/google-icon-2048x2048.png");
    } else if (accountType == 'Facebook') {
      return loginProvider("assets/icons/facebook/Facebook_icon.png");
    } else if (accountType == 'Email') {
      return loginProvider("assets/icons/email/email_icon.png");
    }
    return Text(accountType);
  }
}
