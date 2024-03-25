import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pyoneer/services/user_data.dart';

class Auth {
  static const List<String> adminUIDs = [
    'A0ILxjzDZeQk2okmGUcs85kMCSh2',
    'wA2YJSiuLAQXMZH77esSNHmSVYI2',
    'Jk3eN02jLqPGzdBDygd4psG7LsC3',
    'jFs4rVGELnegEc1fuEvLe57iivG2'
  ];

  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        String email = e.email!;
        showAccountExistsDialog(context, email, 'Google');
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in with Google: $e');
      }
      return null;
    }
  }

  static Future<UserCredential?> signInWithFacebook(
      BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email', 'user_photos'],
      );

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);

          final facebookUser = await FacebookAuth.instance
              .getUserData(fields: "picture.width(200)");
          final pictureUrl = facebookUser['picture']['data']['url'];

          await UserData.saveUserData(userCredential, 'Facebook');
          await UserData.updateUserImage(pictureUrl);

          return userCredential;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            String email = e.email!;
            showAccountExistsDialog(context, email, 'Facebook');
          }
        }
      } else {
        if (kDebugMode) {
          print('Facebook login failed: ${loginResult.message}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in with Facebook: $e');
      }
      return null;
    }

    return null;
  }

  static Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('รหัสผ่านไม่ปลอดภัย'),
              content: const Text(
                  'รหัสผ่านที่คุณป้อนไม่ปลอดภัย โปรดใช้รหัสผ่านที่ปลอดภัยมากขึ้น'),
              actions: [
                TextButton(
                  child: const Text('ตกลง'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('อีเมลนี้ถูกใช้แล้ว'),
              content: Text(
                  'อีเมล $email ได้ถูกใช้ลงทะเบียนแล้ว โปรดใช้อีเมลอื่นหรือลงชื่อเข้าใช้ด้วยอีเมลนี้'),
              actions: [
                TextButton(
                  child: const Text('ตกลง'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  static Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        String email = e.email!;
        showAccountExistsDialog(context, email, 'email/password');
      } else if (e.code == 'invalid-email') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('อีเมลไม่ถูกต้อง'),
              content: const Text('รูปแบบอีเมลที่คุณป้อนไม่ถูกต้อง'),
              actions: [
                TextButton(
                  child: const Text('ตกลง'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('ไม่พบบัญชีผู้ใช้'),
              content: const Text(
                  'ไม่พบบัญชีผู้ใช้ที่เกี่ยวข้องกับอีเมลนี้ โปรดลองอีกครั้งหรือสร้างบัญชีใหม่'),
              actions: [
                TextButton(
                  child: const Text('ตกลง'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('รหัสผ่านหรืออีเมลไม่ถูกต้อง'),
              content: const Text(
                  'รหัสผ่านหรืออีเมลที่คุณป้อนไม่ถูกต้อง โปรดลองอีกครั้ง'),
              actions: [
                TextButton(
                  child: const Text('ตกลง'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (e.code == 'wrong-email') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('อีเมลsหรือรหัสผ่านไม่ถูกต้อง'),
              content: const Text(
                  'อีเมลหรือรหัสผ่านที่คุณป้อนไม่ถูกต้อง โปรดลองอีกครั้ง'),
              actions: [
                TextButton(
                  child: const Text('ตกลง'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        if (kDebugMode) {
          print('Error signing in with email/password: $e');
        }
      }
      return null;
    }
  }

  // static Future<UserCredential?> checkExistingUser(String email) async {
  //   try {
  //     List<String> signInMethods =
  //         await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  //     if (signInMethods.isNotEmpty) {
  //       return await FirebaseAuth.instance.signInWithEmailAndPassword(
  //           email: email, password: 'dummy-password');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error checking existing user: $e');
  //     }
  //   }
  //   return null;
  // }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await UserData.clear();
  }

  static void showAccountExistsDialog(
      BuildContext context, String email, String loginMethod) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('มีบัญชีผู้ใช้แล้ว'),
          content: Text(
            'อีเมล "$email" ได้ถูกใช้ลงชื่อเข้าใช้ด้วยวิธีอื่นแล้ว โปรดลองเข้าสู่ระบบโดยใช้วิธีอื่น หรือใช้บัญชีอีเมลใหม่เพื่อเข้าสู่ระบบด้วยวิธี "$loginMethod"',
          ),
          actions: [
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
