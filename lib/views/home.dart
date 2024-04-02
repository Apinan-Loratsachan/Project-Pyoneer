import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/models/navigation_bar_icon_animation.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/animation.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/utils/hero.dart';
import 'package:pyoneer/views/account.dart';
import 'package:pyoneer/views/content.dart';
import 'package:pyoneer/views/ide.dart';
import 'package:pyoneer/views/menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const Key primaryScreenKey = PageStorageKey('menuScreen');
  static const Key contentScreenKey = PageStorageKey('contentScreen');
  static const Key ideScreenKey = PageStorageKey('ideScreen');

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? lastPressedTime;
  int currentIndex = 1;
  late final PageController pageController;

  List<Map<String, dynamic>> popups = [];

  final List<Widget> _children = [
    const MenuScreen(key: HomeScreen.primaryScreenKey),
    const ContentScreen(key: HomeScreen.contentScreenKey),
    const IDEScreen(key: HomeScreen.ideScreenKey),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
    fetchPopupData();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void fetchPopupData() {
    FirebaseFirestore.instance
        .collection('popupnews')
        .where('showStatus', isEqualTo: "1")
        .get()
        .then((QuerySnapshot querySnapshot) {
      final List<Map<String, dynamic>> fetchedPopups = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((data) => data['showStatus'] == "1")
          .toList();
      if (fetchedPopups.isNotEmpty) {
        showPopupsSequentially(fetchedPopups, 0);
      }
    });
  }

  void showPopupsSequentially(List<Map<String, dynamic>> popups, int index) {
    if (index < popups.length) {
      showPopupDialog(popups[index]).then((_) {
        showPopupsSequentially(popups, index + 1);
      });
    }
  }

  Future<void> showPopupDialog(Map<String, dynamic> currentPopup) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
              surfaceTintColor: Theme.of(context).colorScheme.background,
              backgroundColor:
                  Theme.of(context).colorScheme.background.withOpacity(0.5),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (currentPopup['imageUrl'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(currentPopup['imageUrl']),
                    ),
                  if (currentPopup['text'] != null &&
                      currentPopup['text'].isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(currentPopup['text']),
                    ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: const EdgeInsets.only(bottom: 8.0),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        );
      },
    );
  }

  void onDestinationSelected(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () {
      pageController.animateToPage(
        index,
        duration: Duration(
            milliseconds: PyoneerAnimation.pageviewChangeScreenDuration),
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
          appBar: AppBar(
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
                    transitionDuration: Duration(
                        milliseconds: PyoneerAnimation.changeScreenDuration),
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
                child: ValueListenableBuilder<String>(
                  valueListenable: UserData.imageNotifier,
                  builder: (context, imageUrl, _) {
                    return imageUrl.isEmpty ||
                            UserData.email == 'ไม่ได้เข้าสู่ระบบ'
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
                                    imageUrl,
                                  ),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              )
            ],
            toolbarHeight: 60,
          ),
          extendBody: true,
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
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 150.0,
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity:
                      MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: IgnorePointer(
                    child: Container(
                      height: currentIndex == 1 ? 150 : 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Theme.of(context).colorScheme.background,
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0),
                          ],
                          stops: const [0.2, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity:
                      MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: NavigationBar(
                      surfaceTintColor: Colors.transparent,
                      indicatorColor:
                          AppColor.primarSnakeColor.withOpacity(0.5),
                      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      backgroundColor: Colors.transparent,
                      labelBehavior:
                          NavigationDestinationLabelBehavior.onlyShowSelected,
                      onDestinationSelected: onDestinationSelected,
                      selectedIndex: currentIndex,
                      destinations: <Widget>[
                        NavigationDestination(
                          icon: AnimatedNavigationIcon(
                            icon: FontAwesomeIcons.solidCompass,
                            selectedIcon: FontAwesomeIcons.compass,
                            isSelected: currentIndex == 0,
                          ),
                          label: 'สำรวจ',
                        ),
                        NavigationDestination(
                          icon: AnimatedNavigationIcon(
                            icon: FontAwesomeIcons.book,
                            selectedIcon: FontAwesomeIcons.bookOpen,
                            isSelected: currentIndex == 1,
                          ),
                          label: 'บทเรียน',
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
              ],
            ),
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
