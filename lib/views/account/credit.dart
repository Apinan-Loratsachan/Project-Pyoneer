import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/utils/hero.dart';
import 'package:pyoneer/utils/type_writer_text.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Deverloper"),
      ),
      body: Center(
        child: Column(
          children: [
            PyoneerHero.hero(
                Image.asset(
                  "assets/icons/pyoneer_snake.png",
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                "dev-snake"),
            PyoneerHero.hero(
                Image.asset(
                  "assets/icons/pyoneer_text.png",
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                "dev-text"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    width: double.infinity,
                    color: AppColor.ideColor,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TypeWriterText(
                            text:
                                "PY৹NEER\nDevelopment Team\n\nApinan Loratsachan\nKraisorn Kuiraksa\nNichakorn Wangwitthayothin\n\nAsst. Prof. Chanintorn Chalermsuk\n\nFaculty of Arts and Sciences,\nDepartment of Digital Technology\nand Innovation\nSoutheast Asia University\n\nCopyright © 2024 PY৹NEER,\nAll right reserved",
                            textStyle: TextStyle(color: Colors.white),
                            typingSpeed: 50,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )),
              ),
            ).animate(
              delay: const Duration(milliseconds: 250),
              effects: [
                const SlideEffect(
                  duration: Duration(milliseconds: 1000),
                  begin: Offset(0, 0.5),
                ),
                const FadeEffect(
                  duration: Duration(milliseconds: 1000),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
