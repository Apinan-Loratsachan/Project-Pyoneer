import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ContentCounter {
  static int newsCounter = 0;

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

  static Future<void> updateNewsItemCount() async {
    try {
      var counterDocument = await FirebaseFirestore.instance
          .collection('counters')
          .doc('newsCounter')
          .get();

      int currentCounter = counterDocument.exists
          ? counterDocument.data()!['count']
          : 0;

      await FirebaseFirestore.instance
          .collection('counters')
          .doc('newsCounter')
          .set({'count': currentCounter + 1});

      newsCounter = currentCounter + 1;
    } catch (e) {
      if (kDebugMode) {
        print('Error updating news item count: $e');
      }
    }
  }
}
