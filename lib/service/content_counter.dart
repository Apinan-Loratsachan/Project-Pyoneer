import 'package:cloud_firestore/cloud_firestore.dart';

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
      // ignore: avoid_print
      print('Error getting news item count: $e');
      return 0;
    }
  }
}
