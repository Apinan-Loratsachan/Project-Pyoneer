import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pyoneer/service/user_data.dart';

Future<UserCredential?> signInWithGoogle() async {
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

    UserData.userName = userCredential.user?.displayName ?? "";
    UserData.email = userCredential.user?.email ?? "";
    UserData.image = userCredential.user?.photoURL ?? "";

    return userCredential;
  } catch (e) {
    if (kDebugMode) {
      print('Error signing in with Google: $e');
    }
    return null;
  }
}
