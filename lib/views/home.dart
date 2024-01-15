import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/views/account.dart';
import 'package:pyoneer/views/content.dart';
import 'package:pyoneer/views/ide.dart';
import 'package:pyoneer/views/primary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? lastPressedTime;
  int currentIndex = 1;
  late final PageController _pageController;

  final List<Widget> _children = [
    const ContentScreen(),
    const PrimaryScreen(),
    const IDEScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onDestinationSelected(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "hero-title",
                    child: Image.asset(
                      "assets/icons/pyoneer_snake.png",
                      fit: BoxFit.cover,
                      height: 60,
                    ),
                  ),
                  Image.asset(
                    "assets/icons/pyoneer_text.png",
                    fit: BoxFit.cover,
                    height: 40,
                  )
                ],
              ),
            ],
          ),
          leading: Container(),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountSettigScreen(),
                ),
              ),
              borderRadius:
                  BorderRadius.circular(50),
              customBorder:
                  const CircleBorder(),
              child: UserData.image == "" || UserData.image.isEmpty
                  ? const Icon(FontAwesomeIcons.person)
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          UserData.image,
                        ),
                      ),
                    ),
            )
          ],
          toolbarHeight: 60,
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: _children,
        ),
        bottomNavigationBar: NavigationBar(
          surfaceTintColor: Colors.white,
          indicatorColor: AppColor.primarSnakeColor.withOpacity(0.5),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // onDestinationSelected: (int index) {
          //   setState(() {
          //     currentIndex = index;
          //   });
          // },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: onDestinationSelected,
          selectedIndex: currentIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.bookOpen),
              label: 'บทเรียน',
              selectedIcon: FaIcon(FontAwesomeIcons.bookOpenReader),
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.home),
              label: 'หน้าหลัก',
              selectedIcon: FaIcon(FontAwesomeIcons.homeUser),
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.code),
              label: 'IDE',
              selectedIcon: FaIcon(FontAwesomeIcons.laptopCode),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (lastPressedTime == null ||
        now.difference(lastPressedTime!) > const Duration(seconds: 2)) {
      lastPressedTime = now;
      Fluttertoast.showToast(
        msg: "Press again to exit",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
