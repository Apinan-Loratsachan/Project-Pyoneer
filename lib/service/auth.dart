import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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

    UserData.uid = userCredential.user?.uid ?? "";
    UserData.userName = userCredential.user?.displayName ?? "";
    UserData.email = userCredential.user?.email ?? "";
    UserData.image = userCredential.user?.photoURL ?? "";
    UserData.tel = userCredential.user?.phoneNumber ?? "";

    UserData.saveUserData(userCredential);

    return userCredential;
  } catch (e) {
    if (kDebugMode) {
      print('Error signing in with Google: $e');
    }
    return null;
  }
}

Future<UserCredential?> signInWithFacebook() async {
  try {
    // Trigger the Facebook login process
    final LoginResult result = await FacebookAuth.instance.login();

    // Check if the login was successful
    if (result.status == LoginStatus.success) {
      // Get the Facebook authentication token
      final AccessToken accessToken = result.accessToken!;

      // Create a Facebook auth credential
      final AuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);

      // Sign in to Firebase with the Facebook auth credential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Update user data
      UserData.uid = userCredential.user?.uid ?? "";
      UserData.userName = userCredential.user?.displayName ?? "";
      UserData.email = userCredential.user?.email ?? "";
      UserData.image = userCredential.user?.photoURL ?? "";
      UserData.tel = userCredential.user?.phoneNumber ?? "";

      UserData.saveUserData(userCredential);

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

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  // await FacebookAuth.instance.logOut();
  await UserData.clear();
}
