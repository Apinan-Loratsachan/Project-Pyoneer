import 'package:flutter/material.dart';

class OfflineWarningScreen extends StatelessWidget {
  const OfflineWarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_outlined, size: 100),
            SizedBox(height: 20),
            Text(
              'ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'กรุณาเชื่อมต่ออินเทอร์เน็ตเพื่อใช้งานแอปพลิเคชัน',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
