import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/services/content_counter.dart';
import 'package:pyoneer/services/launch_url.dart';
import 'package:pyoneer/utils/animation.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/utils/hero.dart';
import 'package:pyoneer/views/menu/challenge/challenge_guide.dart';
import 'package:pyoneer/views/menu/challenge/leaderboard_screen.dart';
import 'package:pyoneer/views/menu/learning_hub.dart';
import 'package:pyoneer/views/menu/news.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<MenuScreen>
    with AutomaticKeepAliveClientMixin {
  final double listTileSpace = 15;
  Future<int>? newsItemCountFuture;
  Future<int>? learningItemCountFuture;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    newsItemCountFuture = ContentCounter.getNewsItemCount();
    learningItemCountFuture = ContentCounter.getLearningItemCount();
  }

  void refreshNewsItemCount() {
    setState(() {
      newsItemCountFuture = ContentCounter.getNewsItemCount();
      learningItemCountFuture = ContentCounter.getLearningItemCount();
    });
  }

  // void addExamQuestions() async {
  //   final firestore = FirebaseFirestore.instance;

  //   for (int i = 1; i <= 100; i++) {
  //     String docId = i.toString().padLeft(4, '0');

  //     await firestore.collection('challengeQuestion').doc(docId).set({
  //       'choice': [
  //         'question$i choice1',
  //         'question$i choice2',
  //         'question$i choice3',
  //         'question$i choice4'
  //       ],
  //       'correctChoice': 'question$i choice1',
  //       'imageUrl': '',
  //       'question': 'question $i'
  //     });
  //   }

  //   print('Added 100 exam questions to Firestore.');
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.compass),
            SizedBox(width: 15),
            Text(
              "สำรวจ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ).animate(
          onPlay: (controller) => controller.repeat(),
          effects: [
            const ShimmerEffect(
                delay: Duration(milliseconds: 500),
                duration: Duration(milliseconds: 1000),
                color: Colors.blue,
                angle: 180),
            const ShimmerEffect(
              delay: Duration(milliseconds: 800),
              duration: Duration(milliseconds: 1000),
              color: Colors.deepPurpleAccent,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    leading: PyoneerHero.hero(
                        Image.asset("assets/icons/news.png"), "news-icon"),
                    title: const Text(
                      "Python news",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    subtitle: const Text("ข่าวสารไพทอน",
                        style: TextStyle(fontSize: 12)),
                    // FutureBuilder<int>(
                    //   future: newsItemCountFuture,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.done) {
                    //       if (snapshot.hasError) {
                    //         // Handle error case
                    //         return const Text('0 รายการ');
                    //       }

                    //       // Display the news count as a string in the trailing
                    //       return PyoneerHero.hero(
                    //         Text(
                    //           '${snapshot.data} รายการ',
                    //           style: const TextStyle(fontSize: 12),
                    //         ),
                    //         "news-counter",
                    //       );
                    //     } else {
                    //       // Display a loading indicator while waiting for the data
                    //       return const Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: SizedBox(
                    //           height: 14,
                    //           width: 14,
                    //           child: Padding(
                    //             padding: EdgeInsets.all(3.0),
                    //             child: CircularProgressIndicator(
                    //               strokeWidth: 2,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),
                    onTap: () {
                      PyoneerAnimation.changeScreen(context, const NewsScreen())
                          .then((value) => refreshNewsItemCount());
                    },
                  ),
                  SizedBox(height: listTileSpace),
                  ListTile(
                    leading: Image.asset("assets/images/lesson0/cover.png"),
                    title: const Text(
                      "Python update",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text("ไพทอนอัพเดท",
                        style: TextStyle(fontSize: 12)),
                    trailing:
                        const Icon(FontAwesomeIcons.arrowUpRightFromSquare),
                    onTap: () {
                      LaunchURL.launchSrtingURL("https://blog.python.org/");
                    },
                  ),
                  SizedBox(height: listTileSpace),
                  ListTile(
                    leading: PyoneerHero.hero(
                        Image.asset("assets/icons/library.png"),
                        "library-icon"),
                    title: const Text(
                      "Python E-Learning",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    subtitle: const Text("ศูนย์การเรียนรู้ไพทอน",
                        style: TextStyle(fontSize: 12)),
                    // FutureBuilder<int>(
                    //   future: learningItemCountFuture,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.done) {
                    //       if (snapshot.hasError) {
                    //         // Handle error case
                    //         return const Text('0 รายการ');
                    //       }

                    //       // Display the news count as a string in the trailing
                    //       return PyoneerHero.hero(
                    //         Text(
                    //           '${snapshot.data} รายการ',
                    //           style: const TextStyle(fontSize: 12),
                    //         ),
                    //         "library-counter",
                    //       );
                    //     } else {
                    //       // Display a loading indicator while waiting for the data
                    //       return const Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: SizedBox(
                    //           height: 14,
                    //           width: 14,
                    //           child: Padding(
                    //             padding: EdgeInsets.all(3.0),
                    //             child: CircularProgressIndicator(
                    //               strokeWidth: 2,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     }
                    //   },
                    // ),
                    onTap: () {
                      PyoneerAnimation.changeScreen(
                              context, const LearningHubScreen())
                          .then((value) => refreshNewsItemCount());
                    },
                  ),
                  SizedBox(height: listTileSpace),
                  ListTile(
                    leading: PyoneerHero.hero(
                        Image.asset("assets/icons/challenge_icon.png"),
                        "challenge-icon"),
                    title: const Text(
                      "Leaderboard",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text("อันดับผู้เล่น Challenge",
                        style: TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      PyoneerAnimation.changeScreen(
                          context, const LeaderboardScreen());
                    },
                  ),
                  SizedBox(height: listTileSpace),
                ],
              ),
            ),
            Animate(
              delay: const Duration(milliseconds: 500),
              effects: const [
                FadeEffect(
                  duration: Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                ),
                SlideEffect(
                  duration: Duration(milliseconds: 1000),
                  begin: Offset(0, 0.5),
                  curve: Curves.easeInOut,
                )
              ],
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: ElevatedButton(
                  onPressed: () {
                    PyoneerAnimation.changeScreen(
                        context, const ChallengeGuideScreen());
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side:
                            const BorderSide(color: AppColor.primarSnakeColor),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/quiz.png",
                          height: 50,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text("Challenge"),
                      ],
                    ),
                  ).animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                    effects: [
                      const ScaleEffect(
                          duration: Duration(milliseconds: 1000),
                          begin: Offset(1, 1),
                          end: Offset(1.2, 1.2),
                          curve: Curves.easeInOut),
                    ],
                  ),
                ),
              ).animate(
                effects: [
                  const FadeEffect(
                      duration: Duration(milliseconds: 2000),
                      curve: Curves.easeInOut),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
