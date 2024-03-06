import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pyoneer/services/user_data.dart';

class ContentCounter {
  static int newsCounter = 0;
  static int learningCounter = 0;

  static Future<int> getNewsItemCount() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('news')
          .orderBy('timestamp', descending: true)
          .get();

      newsCounter = querySnapshot.size;
      return querySnapshot.size;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting news item count: $e');
      }
      return 0;
    }
  }

  static Future<int> getLearningItemCount() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('learning')
          .get();

      learningCounter = querySnapshot.size;
      return querySnapshot.size;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting news item count: $e');
      }
      return 0;
    }
  }

  static Future<bool> checkAlreadyTesting(String email, int lessonTest, String testType) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('testResult')
        .doc(UserData.email)
        .collection(testType)
        .where('email', isEqualTo: email)
        .where('lessonTest', isEqualTo: lessonTest)
        .where('testType', isEqualTo: testType)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}
