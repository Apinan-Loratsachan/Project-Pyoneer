import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static String uid = "";
  static String userName = "";
  static String email = "";
  static String image = "";
  static String tel = "";
  static List<String> accountType = ["Email", "Google", "Facebook", "Line"];
  static int loginType = 0;

  static Future<void> saveUserData(UserCredential userCredential) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', userCredential.user?.uid ?? "");
    await prefs.setString('userName', userCredential.user?.displayName ?? "");
    await prefs.setString('email', userCredential.user?.email ?? "");
    await prefs.setString('image', userCredential.user?.photoURL ?? "");
    await prefs.setString('tel', userCredential.user?.phoneNumber ?? "");
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    uid = "";
    userName = "";
    email = "";
    image = "";
    tel = "";
  }

  static Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? "";
    userName = prefs.getString('userName') ?? "";
    email = prefs.getString('email') ?? "";
    image = prefs.getString('image') ?? "";
    tel = prefs.getString('tel') ?? "";
  }

  // static clear() {
  //   uid = "";
  //   userName = "";
  //   email = "";
  //   image = "";
  //   tel = "";
  // }
}
