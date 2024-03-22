import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/animate_fade_slide.dart';
import 'package:pyoneer/views/home.dart';
import 'package:pyoneer/views/register.dart';
import 'package:pyoneer/services/auth.dart';

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

  String _appVersion = '';
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();

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
                  Image.asset(
                    'assets/icons/pyoneer_bg_less.png',
                    height: MediaQuery.of(context).size.height * 0.3,
                  ).animateFadeSlide(),
                  const SizedBox(height: 0),
                  const Text(
                    'Created By DTI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ).animateFadeSlide(),
                  const SizedBox(height: 28),
                  TextFormField(
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
                    },
                  ).animateFadeSlide(),
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
                  ).animateFadeSlide(),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      UserCredential? userCredential =
                          await Auth.signInWithEmailAndPassword(
                              _email, _password);
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
                  ).animateFadeSlide(),
                  const SizedBox(height: 16),
                  const Center(child: Text('หรือ'))
                      .animate(
                        onPlay: (controller) => controller.forward(),
                      )
                      .fade()
                      .slide(
                          begin: const Offset(0.0, 1.0),
                          duration: 1500.ms,
                          curve: Curves.easeInOut),
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
                              await Auth.signInWithGoogle();
                          if (userCredential != null) {
                            await UserData.saveUserData(
                                userCredential, 'Google');
                            await UserData.loadUserData();
                            if (mounted) {
                              Navigator.pushReplacement(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const HomeScreen()
                                            .animate()
                                            .fade()
                                            .slide(),
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                  ));
                            }
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
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    const HomeScreen().animate().fade().slide(),
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                              ));
                        },
                        color: Colors.grey,
                      ),
                    ],
                  ).animateFadeSlide(),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("ยังไม่มีบัญชี?"),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    const RegisterScreen().animate().slide(),
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                              ));
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
                  ).animateFadeSlide(),
                  const SizedBox(height: 24),
                  Text(
                    _appVersion,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ).animateFadeSlide(),
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
