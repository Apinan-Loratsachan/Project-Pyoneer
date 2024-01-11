import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class LessonComponent {
  static AppBar lessonsAppbar(String titleText,String subTitleText) {
    return AppBar(
      title: Row(
        children: [
          const SizedBox(width: 0),
          Hero(
            tag: "hero-title",
            child: Image.asset(
              "assets/icons/pyoneer_snake.png",
              fit: BoxFit.cover,
              height: 60,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(titleText),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
            subTitleText,
            style: const TextStyle(
              fontSize: 16
            ),
          ),
              ),
            ],
          ),
        ],
      ),
      toolbarHeight: 70,
    );
  }

  static Hero lessonCover(String imagePath, String heroTag) {
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(imagePath),
      ),
    );
  }

  static Widget lessonImage(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            var screenSize = MediaQuery.of(context).size;

            var width = screenSize.width;
            var height = screenSize.height;

            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: PhotoView(
                      imageProvider: AssetImage(
                        imagePath,
                      ),
                      minScale: PhotoViewComputedScale.contained * 1,
                      maxScale: PhotoViewComputedScale.covered * 4.0,
                      initialScale: PhotoViewComputedScale.contained,
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      basePosition: Alignment.center,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Image.asset(
        imagePath,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Text(
            'Image not found',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              decoration: TextDecoration.lineThrough,
            ),
          );
        },
      ),
    );
  }
}
