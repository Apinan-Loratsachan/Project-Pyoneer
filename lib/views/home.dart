import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/models/navigation_bar_icon_animation.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/utils/animation.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/utils/hero.dart';
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
  late final PageController pageController;

  final List<Widget> _children = [
    const ContentScreen(key: HomeScreen.contentScreenKey),
    const PrimaryScreen(key: HomeScreen.primaryScreenKey),
    const IDEScreen(key: HomeScreen.ideScreenKey),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onDestinationSelected(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () {
      pageController.animateToPage(
        index,
        duration: Duration(milliseconds: PyoneerAnimation.pageviewChangeScreenDuration),
        curve: PyoneerAnimation.pageviewChangeScreenCurve,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: currentIndex == 2
              ? AppBar(
                  centerTitle: true,
                  toolbarHeight: 60,
                  leading: Container(),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PyoneerHero.hero(
                          Image.asset(
                            "assets/icons/pyoneer_snake.png",
                            fit: BoxFit.cover,
                            height: 60,
                          ),
                          "hero-title"),
                      PyoneerHero.hero(
                          Image.asset(
                            "assets/icons/pyoneer_text.png",
                            fit: BoxFit.cover,
                            height: 40,
                          ),
                          "pyoneer_text-title"),
                    ],
                  ),
                  actions: [
                    IconButton(
                      iconSize: 45,
                      icon: const Icon(Icons.play_circle),
                      onPressed: () {},
                    ),
                  ],
                )
              : AppBar(
                  centerTitle: true,
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PyoneerHero.hero(
                              Image.asset(
                                "assets/icons/pyoneer_snake.png",
                                fit: BoxFit.cover,
                                height: 60,
                              ),
                              "hero-title"),
                          PyoneerHero.hero(
                              Image.asset(
                                "assets/icons/pyoneer_text.png",
                                fit: BoxFit.cover,
                                height: 40,
                              ),
                              "pyoneer_text-title"),
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
                          transitionDuration: Duration(milliseconds: PyoneerAnimation.changeScreenDuration),
                          transitionsBuilder:
                              (context, animation1, animation2, child) {
                            animation1 = CurvedAnimation(
                              parent: animation1,
                              curve: Curves.easeOutQuart,
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
            controller: pageController,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              FocusManager.instance.primaryFocus?.unfocus();
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
