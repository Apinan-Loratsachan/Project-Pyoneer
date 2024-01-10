import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.blue,
    );
  }
}