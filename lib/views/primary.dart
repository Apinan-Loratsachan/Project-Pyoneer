import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/service/content_counter.dart';
import 'package:pyoneer/service/launch_url.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/utils/hero.dart';
import 'package:pyoneer/views/news.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
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
    String greetingWord = _getGreetingWord();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "$greetingWord ${UserData.userName}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: AppColor.primarSnakeColor.withOpacity(0.5),
                        offset: const Offset(0.0, 5.0),
                      ),
                    ],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "รายการ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
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
                            return const Text('Error loading news count');
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
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const NewsScreen(),
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder:
                              (context, animation1, animation2, child) {
                            animation1 = CurvedAnimation(
                              parent: animation1,
                              curve: Curves.easeInOut,
                            );
                            return FadeTransition(
                              opacity: Tween(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(animation1),
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.0, 1.0),
                                  end: Offset.zero,
                                ).animate(animation1),
                                child: child,
                              ),
                            );
                          },
                        ),
                      ).then((value) => refreshNewsItemCount());
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
                      LaunchURL.launchSrtingURL(
                          "https://blog.python.org/");
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
                        Image.asset("assets/icons/unknow2.png"), "menu3-icon"),
                    title: const Text(
                      "อะไรสักอย่าง 2",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Text("0 รายการ"),
                    onTap: () {},
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
          ],
        ),
      ),
    );
  }
}

String _getGreetingWord() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 4 && hour < 12) {
    return '🌤️ อรุณสวัสดิ์';
  } else if (hour >= 12 && hour < 16) {
    return '☀️ สวัสดียามบ่าย';
  } else if (hour >= 16 && hour < 19) {
    return '🌥️ สายัณห์สวัสดิ์';
  } else {
    return '🌙 สวัสดียามค่ำ';
  }
}
