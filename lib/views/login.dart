import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/animate_fade_slide.dart';
import 'package:pyoneer/utils/animation.dart';
import 'package:pyoneer/views/account/profile_picture_upload.dart';
import 'package:pyoneer/views/home.dart';
import 'package:pyoneer/views/register.dart';
import 'package:pyoneer/services/auth.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool _obscureText = true;
  bool _isFieldEmpty = true;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _appVersion = '';
  String _email = '';
  String _password = '';
  bool isFirstAnimate = true;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();

    isFirstAnimate = true;

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
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'v${info.version}';
    });
  }

  void navigateToHomeScreen() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const HomeScreen(),
          transitionDuration:
              Duration(milliseconds: PyoneerAnimation.changeScreenDuration),
          transitionsBuilder: (context, animation1, animation2, child) {
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
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation1),
                child: child,
              ),
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
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
                  isFirstAnimate
                      ? Hero(
                          tag: 'login-logo',
                          child: Image.asset(
                            'assets/icons/pyoneer_bg_less.png',
                            height: MediaQuery.of(context).size.height * 0.3,
                          ).animate(
                            effects: [
                              const FadeEffect(
                                duration: Duration(milliseconds: 1000),
                              ),
                              const SlideEffect(
                                curve: Curves.easeInOut,
                                begin: Offset(0, 0.5),
                                duration: Duration(milliseconds: 1000),
                              ),
                            ],
                            onComplete: (controller) => setState(() {
                              isFirstAnimate = false;
                            }),
                          ),
                        )
                      : Hero(
                          tag: 'login-logo',
                          child: Image.asset(
                            'assets/icons/pyoneer_bg_less.png',
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                  const SizedBox(height: 0),
                  const Text(
                    'Created By DTI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ).loginAnimate(delay: const Duration(milliseconds: 250)),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'อีเมล',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    autofillHints: const [AutofillHints.email],
                    onChanged: (value) {
                      _email = value;
                      _emailController.text = value;
                    },
                  ).loginAnimate(delay: const Duration(milliseconds: 500)),
                  const SizedBox(height: 16),
                  TextFormField(
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
                    onChanged: (value) {
                      _password = value;
                    },
                  ).loginAnimate(delay: const Duration(milliseconds: 750)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final TextEditingController resetEmailController =
                              TextEditingController();
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('รีเซ็ตรหัสผ่าน'),
                                content: TextField(
                                  controller: resetEmailController,
                                  decoration:
                                      const InputDecoration(hintText: "อีเมล"),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('ส่งการรีเซ็ตรหัสผ่าน'),
                                    onPressed: () async {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                          if (result == true) {
                            if (resetEmailController.text.isNotEmpty) {
                              try {
                                await Auth.sendPasswordResetEmail(
                                    resetEmailController.text);
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message:
                                        'รีเซ็ตรหัสผ่านได้ถูกส่งไปยังอีเมล ${resetEmailController.text} แล้ว',
                                  ),
                                  displayDuration: const Duration(seconds: 3),
                                );
                              } on FirebaseAuthException catch (e) {
                                String errorMessage =
                                    'เกิดข้อผิดพลาดไม่คาดคิดขณะรีเซ็ตรหัสผ่าน โปรดลองอีกครั้งในภายหลัง';
                                if (e.code == 'user-not-found') {
                                  errorMessage =
                                      'ไม่พบผู้ใช้ที่ตรงกับอีเมลที่คุณป้อน';
                                }
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: errorMessage,
                                  ),
                                  displayDuration: const Duration(seconds: 3),
                                );
                              } catch (e) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message:
                                        'เกิดข้อผิดพลาดไม่คาดคิด โปรดลองอีกครั้งในภายหลัง',
                                  ),
                                  displayDuration: const Duration(seconds: 3),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'กรุณากรอกอีเมลที่ต้องการรีเซ็ตรหัสผ่าน'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              showTopSnackBar(
                                Overlay.of(context),
                                const CustomSnackBar.info(
                                  message:
                                      'กรุณากรอกอีเมลที่ต้องการรีเซ็ตรหัสผ่าน',
                                ),
                                displayDuration: const Duration(seconds: 3),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'ลืมรหัสผ่าน?',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ).loginAnimate(delay: const Duration(milliseconds: 1000)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      UserCredential? userCredential =
                          await Auth.signInWithEmailAndPassword(
                              _email, _password, context);
                      if (userCredential != null) {
                        await UserData.saveUserData(userCredential, 'Email');
                        await UserData.loadUserData();
                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  const HomeScreen().animate().fade().slide(),
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('ล็อกอินไม่สำเร็จ'),
                            content:
                                const Text('กรุณาตรวจสอบอีเมลหรือรหัสผ่าน'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('ตกลง'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF1ABDAD),
                    ),
                    child: const Text('เข้าสู่ระบบ'),
                  ).animate(effects: [
                    const ScaleEffect(
                        curve: Curves.easeInOut,
                        delay: Duration(milliseconds: 1250),
                        duration: Duration(milliseconds: 1000))
                  ]),
                  const SizedBox(height: 16),
                  const Center(child: Text('หรือ'))
                      .loginAnimate(delay: const Duration(milliseconds: 1500)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/icons/google/icons8-google-48.svg',
                          height: 26,
                        ),
                        onPressed: () async {
                          UserCredential? userCredential =
                              await Auth.signInWithGoogle(context);
                          if (userCredential != null) {
                            await UserData.saveUserData(
                                userCredential, 'Google');
                            await UserData.loadUserData();
                            navigateToHomeScreen();
                          } else {}
                        },
                      ),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.facebook),
                        onPressed: () async {
                          UserCredential? userCredential =
                              await Auth.signInWithFacebook(context);
                          if (userCredential != null) {
                            await UserData.loadUserData();
                            navigateToHomeScreen();
                          } else {
                            // User cancelled the sign in process or sign in failed
                          }
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
                              pageBuilder: (context, animation1, animation2) =>
                                  const HomeScreen(),
                              transitionDuration: Duration(
                                  milliseconds:
                                      PyoneerAnimation.changeScreenDuration),
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
                  ).loginAnimate(delay: const Duration(milliseconds: 1750)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("ยังไม่มีบัญชี?"),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const RegisterScreen(),
                              transitionDuration: Duration(
                                  milliseconds:
                                      PyoneerAnimation.changeScreenDuration),
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
                                      begin: const Offset(0.0, 1.0),
                                      end: Offset.zero,
                                    ).animate(animation1),
                                    child: child,
                                  ),
                                );
                              },
                            ),
                          );

                          if (result != null && result is String) {
                            setState(() {
                              _emailController.text = result;
                              _email = result;
                            });
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const ProfilePictureUploadScreen(),
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return child.animate().slide(
                                        begin: const Offset(0.0, 1.0),
                                        end: Offset.zero,
                                      );
                                },
                              ),
                            );
                          }
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
                  ).animate(effects: [
                    const ScaleEffect(
                        curve: Curves.easeInOut,
                        delay: Duration(milliseconds: 2000),
                        duration: Duration(milliseconds: 1000))
                  ]),
                  const SizedBox(height: 24),
                  Text(
                    _appVersion,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ).animate(effects: [
                    const ScaleEffect(
                        curve: Curves.easeInOut,
                        delay: Duration(milliseconds: 2250),
                        duration: Duration(milliseconds: 1000))
                  ]),
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
