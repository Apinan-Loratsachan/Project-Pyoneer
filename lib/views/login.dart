import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/views/home.dart';
// import 'package:pyoneer/utils/text.dart';
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
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                      // child: const Text(
                      //   'Login',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 20,
                      //   ),
                      // ),
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
                          // Navigator.pushReplacement(
                          //   context,
                          //   PageRouteBuilder(
                          //     pageBuilder:
                          //         (context, animation, secondaryAnimation) =>
                          //             const HomeScreen(),
                          //     transitionDuration:
                          //         const Duration(milliseconds: 500),
                          //     transitionsBuilder: (context, animation,
                          //         secondaryAnimation, child) {
                          //       animation = CurvedAnimation(
                          //           parent: animation, curve: Curves.easeInOut);
                          //       return FadeTransition(
                          //         opacity: animation,
                          //         child: child,
                          //       );
                          //     },
                          //   ),
                          // );
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
                            icon: const FaIcon(FontAwesomeIcons.google),
                            onPressed: () async {
                              UserCredential? userCredential =
                                  await signInWithGoogle();
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
                            color: Colors.blue[500],
                          ),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.facebook),
                            onPressed: () async {
                              // Handle Facebook login
                              UserCredential? userCredential =
                                  await signInWithFacebook();
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
                            color: Colors.blue,
                          ),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.userSecret),
                            onPressed: () {
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
                  GestureDetector(
                    onTap: () {
                      // Navigate to login page
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const RegisterScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: animation.drive(Tween(
                                      begin: const Offset(0.0, 1.0),
                                      end: Offset.zero)
                                  .chain(CurveTween(curve: Curves.ease))),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: SlideTransition(
                      position: _threePartySlideAnimation,
                      child: FadeTransition(
                        opacity: _threePartyFadeAnimation,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: 'ยังไม่มีบัญชี? ',
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'สมัครสมาชิก',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
