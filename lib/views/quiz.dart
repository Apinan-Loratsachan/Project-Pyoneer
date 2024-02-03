import 'package:flutter/material.dart';
import 'package:pyoneer/service/content_counter.dart';
import 'package:pyoneer/utils/hero.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        flexibleSpace: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PyoneerHero.hero(
                    Image.asset(
                      "assets/icons/quiz.png",
                      height: 50,
                    ),
                    "quiz-icon",
                  ),
                  Column(
                    children: [
                      Hero(
                        tag: "pyoneer_text-title",
                        child: Image.asset(
                          "assets/icons/pyoneer_text.png",
                          fit: BoxFit.cover,
                          height: 60,
                        ),
                      ),
                      PyoneerHero.hero(
                          const Text(
                            "QUIZ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          "quiz-title"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<int>(
              future: ContentCounter.getNewsItemCount(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // Handle error case
                    return const Text('0 รายการ');
                  }

                  // Display the news count as a string in the trailing
                  return PyoneerHero.hero(
                    Text(
                      '${snapshot.data} รายการ',
                      style: const TextStyle(fontSize: 12),
                    ),
                    "news-counter",
                  );
                } else {
                  // Display a loading indicator while waiting for the data
                  return const CircularProgressIndicator();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}