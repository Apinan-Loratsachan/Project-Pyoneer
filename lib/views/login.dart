import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/views/home.dart';
import 'package:pyoneer/views/register.dart';
import 'package:pyoneer/service/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _iconFadeAnimation;
  late Animation<Offset> _iconSlideAnimation;
  late Animation<double> _formFadeAnimation;
  late Animation<Offset> _formSlideAnimation;
  late Animation<double> _threePartyFadeAnimation;
  late Animation<Offset> _threePartySlideAnimation;
  bool _obscureText = true;
  bool _isFieldEmpty = true;
  final TextEditingController _controller = TextEditingController();

  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _iconFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _iconSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _formFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.25, 0.75, curve: Curves.easeIn),
      ),
    );
    _formSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.25, 0.75, curve: Curves.easeIn),
      ),
    );

    _threePartyFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
    _threePartySlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.addListener(() {
      if (_controller.text.isEmpty && !_isFieldEmpty) {
        setState(() {
          _isFieldEmpty = true;
        });
      } else if (_controller.text.isNotEmpty && _isFieldEmpty) {
        setState(() {
          _isFieldEmpty = false;
        });
      }
    });

    _fadeController.forward();
    _slideController.forward();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'v${info.version}';
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SlideTransition(
                    position: _iconSlideAnimation,
                    child: FadeTransition(
                      opacity: _iconFadeAnimation,
                      child: Image.asset(
                        'assets/icons/pyoneer_bg_less.png',
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
                  SlideTransition(
                    position: _formSlideAnimation,
                    child: FadeTransition(
                      opacity: _formFadeAnimation,
                      child: const Text(
                        'Created By DTI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SlideTransition(
                    position: _formSlideAnimation,
                    child: FadeTransition(
                      opacity: _formFadeAnimation,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'อีเมล',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        autofillHints: const [AutofillHints.email],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SlideTransition(
                    position: _formSlideAnimation,
                    child: FadeTransition(
                      opacity: _formFadeAnimation,
                      child: TextFormField(
                        controller: _controller,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'รหัสผ่าน',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: _isFieldEmpty
                              ? null
                              : IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                        ),
                        autofillHints: const [AutofillHints.password],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SlideTransition(
                    position: _formSlideAnimation,
                    child: FadeTransition(
                      opacity: _formFadeAnimation,
                      child: ElevatedButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: "ใช้ Google Login ไปก่อน",
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF1ABDAD),
                        ),
                        child: const Text('เข้าสู่ระบบ'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SlideTransition(
                    position: _threePartySlideAnimation,
                    child: FadeTransition(
                        opacity: _threePartyFadeAnimation,
                        child: const Center(child: Text('หรือ'))),
                  ),
                  const SizedBox(height: 16),
                  SlideTransition(
                    position: _threePartySlideAnimation,
                    child: FadeTransition(
                      opacity: _threePartyFadeAnimation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/google/icons8-google-48.svg',
                              height: 26,
                            ),
                            onPressed: () async {
                              UserCredential? userCredential =
                                  await Auth.signInWithGoogle();
                              if (userCredential != null) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const HomeScreen(),
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                    transitionsBuilder: (context, animation1,
                                        animation2, child) {
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
                                );
                              } else {
                                // User cancelled the sign in process or sign in failed
                              }
                            },
                          ),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.facebook),
                            onPressed: () async {
                              await Auth.signInWithFacebook();
                              setState(() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                              });
                            },
                            color: Colors.blue,
                          ),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.userSecret),
                            onPressed: () {
                              UserData.showProfile = false;
                              UserData.uid = "ไม่ได้เข้าสู่ระบบ";
                              UserData.userName = "ไม่ได้เข้าสู่ระบบ";
                              UserData.accountType = 'ไม่ระบุตัวตน';
                              UserData.email = 'ไม่ได้เข้าสู่ระบบ';
                              UserData.tel = 'ไม่ได้เข้าสู่ระบบ';
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const HomeScreen(),
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
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
                              );
                            },
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SlideTransition(
                    position: _threePartySlideAnimation,
                    child: FadeTransition(
                      opacity: _threePartyFadeAnimation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("ยังไม่มีบัญชี?"),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              // Navigate to login page
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const RegisterScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: animation.drive(Tween(
                                              begin: const Offset(0.0, 1.0),
                                              end: Offset.zero)
                                          .chain(
                                              CurveTween(curve: Curves.ease))),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              "สมัครสมาชิก",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
      _appVersion,
      style: const TextStyle(color: Colors.grey, fontSize: 12),
    ),
    const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
