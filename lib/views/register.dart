import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pyoneer/services/auth.dart';
import 'package:pyoneer/utils/animate_fade_slide.dart';
import 'package:pyoneer/views/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _isFieldEmpty = true;
  bool _isFieldEmpty2 = true;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  bool _passwordsMatch = false;
  bool _hasInteractedWithField2 = false;

  String _email = '';
  String _username = '';
  String _password = '';

  @override
  void initState() {
    super.initState();

    _controller1.addListener(() {
      if (_controller1.text.isEmpty && !_isFieldEmpty) {
        setState(() {
          _isFieldEmpty = true;
        });
      } else if (_controller1.text.isNotEmpty && _isFieldEmpty) {
        setState(() {
          _isFieldEmpty = false;
        });
      }
    });
    _controller2.addListener(() {
      if (_controller2.text.isEmpty && !_isFieldEmpty2) {
        setState(() {
          _isFieldEmpty2 = true;
        });
      } else if (_controller2.text.isNotEmpty && _isFieldEmpty2) {
        setState(() {
          _isFieldEmpty2 = false;
        });
      }
      _hasInteractedWithField2 = true;
      _checkPasswordMatch();
    });
  }

  void _checkPasswordMatch() {
    if (_controller1.text.isNotEmpty && _hasInteractedWithField2) {
      if (_controller1.text == _controller2.text) {
        setState(() {
          _passwordsMatch = true;
        });
      } else {
        setState(() {
          _passwordsMatch = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
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
                    height: MediaQuery.of(context).size.height * 0.25,
                  ).animateFadeSlide(),
                  const SizedBox(height: 0),
                  const Text(
                    'สมัครสมาชิก',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ).animateFadeSlide(),
                  const SizedBox(height: 0),
                  const Text(
                    'Created By DTI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ).animateFadeSlide(),
                  const SizedBox(height: 28),
                  Column(
                    children: [
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
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'ชื่อผู้ใช้',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        autofillHints: const [AutofillHints.username],
                        onChanged: (value) {
                          _username = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _controller1,
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
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _controller2,
                        obscureText: _obscureText2,
                        decoration: InputDecoration(
                          labelText: 'ยืนยันรหัสผ่าน',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: _isFieldEmpty2
                              ? null
                              : IconButton(
                                  icon: Icon(
                                    _obscureText2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText2 = !_obscureText2;
                                    });
                                  },
                                ),
                          errorText: (_controller1.text.isNotEmpty &&
                                  _controller2.text.isNotEmpty &&
                                  !_passwordsMatch)
                              ? 'รหัสผ่านไม่ตรงกัน'
                              : null,
                        ),
                        autofillHints: const [AutofillHints.password],
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          if (_passwordsMatch) {
                            UserCredential? userCredential =
                                await Auth.signUpWithEmailAndPassword(
                                    _email, _password);
                            if (userCredential != null) {
                              await userCredential.user
                                  ?.updateDisplayName(_username);

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('สมัครสมาชิกสำเร็จ'),
                                  content: const Text(
                                      'การสมัครสมาชิกเสร็จสมบูรณ์แล้ว'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        if (mounted) {
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  const LoginScreen()
                                                      .animate()
                                                      .fade()
                                                      .slide(),
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 500),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('ปิด'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('สมัครสมาชิกไม่สำเร็จ'),
                                  content: const Text(
                                      'อีเมลนี้มีบัญชีผู้ใช้แล้ว หรือรหัสผ่านไม่ถูกต้อง'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        if (mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('ปิด'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF1ABDAD),
                        ),
                        child: const Text('สมัครสมาชิก'),
                      ),
                    ],
                  ).animateFadeSlide(),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("มีบัญชีอยู่แล้ว?"),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child: const Text(
                          "เข้าสู่ระบบ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ).animateFadeSlide(),
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
