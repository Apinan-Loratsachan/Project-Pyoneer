import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/models/animated_navigation_icon.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/views/account.dart';
import 'package:pyoneer/views/content.dart';
import 'package:pyoneer/views/ide.dart';
import 'package:pyoneer/views/primary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const Key contentScreenKey = PageStorageKey('contentScreen');
  static const Key primaryScreenKey = PageStorageKey('primaryScreen');
  static const Key ideScreenKey = PageStorageKey('ideScreen');

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? lastPressedTime;
  int currentIndex = 1;
  late final PageController _pageController;

  final List<Widget> _children = [
    const ContentScreen(key: HomeScreen.contentScreenKey),
    const PrimaryScreen(key: HomeScreen.primaryScreenKey),
    const IDEScreen(key: HomeScreen.ideScreenKey),
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
    // ignore: deprecated_member_use
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
                  Hero(
                    tag: "pyoneer_text-title",
                    child: Image.asset(
                      "assets/icons/pyoneer_text.png",
                      fit: BoxFit.cover,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          leading: Container(),
          actions: <Widget>[
            InkWell(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const AccountSettigScreen(),
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder: (context, animation1, animation2, child) {
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
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation1),
                        child: child,
                      ),
                    );
                  },
                ),
              ),
              borderRadius: BorderRadius.circular(50),
              customBorder: const CircleBorder(),
              child: UserData.image == "" || UserData.image.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(FontAwesomeIcons.userSecret),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Hero(
                          tag: "profileImage",
                          child: ClipOval(
                            child: Image.network(
                              UserData.image,
                            ),
                          ),
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
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: onDestinationSelected,
          selectedIndex: currentIndex,
          destinations: <Widget>[
            NavigationDestination(
              icon: AnimatedNavigationIcon(
                icon: FontAwesomeIcons.bookOpen,
                selectedIcon: FontAwesomeIcons.bookOpenReader,
                isSelected: currentIndex == 0,
              ),
              label: 'บทเรียน',
            ),
            NavigationDestination(
              icon: AnimatedNavigationIcon(
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.houseUser,
                isSelected: currentIndex == 1,
              ),
              label: 'หน้าหลัก',
            ),
            NavigationDestination(
              icon: AnimatedNavigationIcon(
                icon: FontAwesomeIcons.code,
                selectedIcon: FontAwesomeIcons.laptopCode,
                isSelected: currentIndex == 2,
              ),
              label: 'IDE',
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
        msg: "แตะอีกครั้งเพื่อออก",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
