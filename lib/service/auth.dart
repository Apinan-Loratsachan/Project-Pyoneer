import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pyoneer/service/user_data.dart';

class Auth{
  static const List<String> adminUIDs = [
      '3XlCZTQFqTScyYE0YBz94MJlORs1',
      'A0ILxjzDZeQk2okmGUcs85kMCSh2',
      'wA2YJSiuLAQXMZH77esSNHmSVYI2',
      'fLzQpFJOKVYLrRfcNLKoFqBLOZp1'
    ];

  static Future<UserCredential?> signInWithGoogle() async {
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

    UserData.uid = userCredential.user?.uid ?? "";
    UserData.userName = userCredential.user?.displayName ?? "";
    UserData.email = userCredential.user?.email ?? "";
    UserData.image = userCredential.user?.photoURL ?? "";
    UserData.tel = userCredential.user?.phoneNumber ?? "";
    UserData.accountType = 'Google';

    UserData.saveUserData(userCredential, 'Google');

    return userCredential;
  } catch (e) {
    if (kDebugMode) {
      print('Error signing in with Google: $e');
    }
    return null;
  }
}

static Future<UserCredential?> signInWithFacebook() async {
  try {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      final AuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      UserData.uid = userCredential.user?.uid ?? "";
      UserData.userName = userCredential.user?.displayName ?? "";
      UserData.email = userCredential.user?.email ?? "";
      UserData.image = userCredential.user?.photoURL ?? "";
      UserData.tel = userCredential.user?.phoneNumber ?? "";
      UserData.accountType = 'Facebook';

      UserData.saveUserData(userCredential, 'Facebook');

      return userCredential;
    } else {
      if (kDebugMode) {
        print('Error signing in with Facebook: ${result.status}');
      }
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error signing in with Facebook: $e');
    }
    return null;
  }
}

static Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  await UserData.clear();
}

}
