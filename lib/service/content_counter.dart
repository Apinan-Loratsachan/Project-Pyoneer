import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

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
}
