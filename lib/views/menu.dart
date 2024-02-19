import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/service/content_counter.dart';
import 'package:pyoneer/service/launch_url.dart';
import 'package:pyoneer/utils/animation.dart';
import 'package:pyoneer/utils/hero.dart';
import 'package:pyoneer/views/news.dart';
import 'package:pyoneer/views/quiz.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<MenuScreen> {
  final double listTileSpace = 15;
  Future<int>? newsItemCountFuture;

  @override
  void initState() {
    super.initState();
    newsItemCountFuture = ContentCounter.getNewsItemCount();
  }

  void refreshNewsItemCount() {
    setState(() {
      newsItemCountFuture = ContentCounter.getNewsItemCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.magnifyingGlass),
            SizedBox(width: 15),
            Text(
              "สำรวจ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                leading: PyoneerHero.hero(
                    Image.asset("assets/icons/news.png"), "news-icon"),
                title: const Text(
                  "ข่าวที่น่าสนใจ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                subtitle: FutureBuilder<int>(
                  future: newsItemCountFuture,
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
                      return const Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 14,
                          width: 14,
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                onTap: () {
                  PyoneerAnimation.changeScreen(context, const NewsScreen())
                      .then((value) => refreshNewsItemCount());
                },
              ),
              SizedBox(height: listTileSpace),
              ListTile(
                leading: Image.asset("assets/images/lesson0/cover.png"),
                title: const Text(
                  "Python",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text("ข่าวล่าสุด"),
                trailing: const Icon(FontAwesomeIcons.arrowUpRightFromSquare),
                onTap: () {
                  LaunchURL.launchSrtingURL("https://blog.python.org/");
                },
              ),
              SizedBox(height: listTileSpace),
              ListTile(
                leading: Image.asset("assets/icons/w3schools.png"),
                trailing: const Icon(FontAwesomeIcons.arrowUpRightFromSquare),
                title: const Text(
                  "W3Schools",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text("w3schools.com"),
                onTap: () {
                  LaunchURL.launchSrtingURL(
                      "https://www.w3schools.com/python/");
                },
              ),
              SizedBox(height: listTileSpace),
              ListTile(
                leading: PyoneerHero.hero(
                    Image.asset("assets/icons/quiz.png"), "quiz-icon"),
                title: const Text(
                  "Quiz",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                subtitle: FutureBuilder<int>(
                  future: newsItemCountFuture,
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
                        "quiz-counter",
                      );
                    } else {
                      // Display a loading indicator while waiting for the data
                      return const Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 14,
                          width: 14,
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                onTap: () {
                  PyoneerAnimation.changeScreen(context, const QuizScreen())
                      .then((value) => refreshNewsItemCount());
                },
              ),
              SizedBox(height: listTileSpace),
              ListTile(
                leading: PyoneerHero.hero(
                    Image.asset("assets/icons/unknow3.png"), "menu4-icon"),
                title: const Text(
                  "อะไรสักอย่าง 3",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Text("ไม่รู้ ไม่รู้ ไม่รู้"),
                onTap: () {},
              ),
              SizedBox(height: listTileSpace),
            ],
          ),
        ),
      ),
    );
  }
}
