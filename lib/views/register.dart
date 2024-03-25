import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pyoneer/services/auth.dart';
import 'package:pyoneer/utils/animate_fade_slide.dart';
import 'package:pyoneer/views/account/profile_picture_upload.dart';

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
  bool _passwordsMatch = false;
  bool _hasInteractedWithField2 = false;
  bool _showSuggestions = false;
  String _suggestedDomain = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _email = '';
  String _username = '';
  String _password = '';
  String? _emailError;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'โปรดระบุอีเมล';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'รูปแบบอีเมลไม่ถูกต้อง';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'โปรดระบุรหัสผ่าน';
    }
    if (value.length < 8 || value.length > 16) {
      return 'รหัสผ่านต้องมีอย่างน้อย 8-16 ตัวอักษร';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'โปรดยืนยันรหัสผ่าน';
    }
    if (value != _passwordController.text) {
      return 'รหัสผ่านไม่ตรงกัน';
    }
    return null;
  }

  final List<String> _emailDomains = [
    'gmail.com',
    'outlook.com',
    'hotmail.com',
    'yahoo.com',
    'live.',
  ];

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      if (_passwordController.text.isEmpty && !_isFieldEmpty) {
        setState(() {
          _isFieldEmpty = true;
        });
      } else if (_passwordController.text.isNotEmpty && _isFieldEmpty) {
        setState(() {
          _isFieldEmpty = false;
        });
      }
    });
    _confirmPasswordController.addListener(() {
      if (_confirmPasswordController.text.isEmpty && !_isFieldEmpty2) {
        setState(() {
          _isFieldEmpty2 = true;
        });
      } else if (_confirmPasswordController.text.isNotEmpty && _isFieldEmpty2) {
        setState(() {
          _isFieldEmpty2 = false;
        });
      }
      _hasInteractedWithField2 = true;
      _checkPasswordMatch();
    });
  }

  void _checkPasswordMatch() {
    if (_passwordController.text.isNotEmpty && _hasInteractedWithField2) {
      if (_passwordController.text == _confirmPasswordController.text) {
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

  List<String> _getFilteredDomains() {
    final emailParts = _emailController.text.split('@');
    if (emailParts.length == 2) {
      final typedDomain = emailParts[1].toLowerCase();
      return _emailDomains
          .where((domain) => domain.toLowerCase().startsWith(typedDomain))
          .toList();
    }
    return [];
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'อีเมล',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorText: _emailError,
                        ),
                        autofillHints: const [AutofillHints.email],
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                            _emailError = null;
                            _showSuggestions = value.contains('@');

                            if (_showSuggestions) {
                              final emailParts = value.split('@');
                              if (emailParts.length == 2) {
                                final typedDomain = emailParts[1].toLowerCase();
                                final matchingDomains = _emailDomains
                                    .where((domain) => domain
                                        .toLowerCase()
                                        .startsWith(typedDomain))
                                    .toList();
                                if (matchingDomains.isNotEmpty) {
                                  _suggestedDomain = matchingDomains[0];
                                } else {
                                  _suggestedDomain = '';
                                }
                              }
                            } else {
                              _suggestedDomain = '';
                            }
                          });
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'โปรดระบุอีเมล';
                        //   }
                        //   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        //       .hasMatch(value)) {
                        //     return 'รูปแบบอีเมลไม่ถูกต้อง';
                        //   }
                        //   return null;
                        // },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9@._-]')),
                        ],
                      ),
                      _showSuggestions != false
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Visibility(
                                visible: _showSuggestions &&
                                    _suggestedDomain.isNotEmpty,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('หรือ '),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _emailController.text =
                                              '${_emailController.text.split('@')[0]}@$_suggestedDomain';
                                          _showSuggestions = false;
                                        });
                                      },
                                      child: Text(
                                        '${_emailController.text.split('@')[0]}@$_suggestedDomain',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
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
                        controller: _passwordController,
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
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'โปรดระบุรหัสผ่าน';
                        //   }
                        //   if (value.length < 8 || value.length > 16) {
                        //     return 'รหัสผ่านต้องมีอย่างน้อย 8-16 ตัวอักษร';
                        //   }
                        //   return null;
                        // },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]')),
                          LengthLimitingTextInputFormatter(16),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
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
                          errorText: (_passwordController.text.isNotEmpty &&
                                  _confirmPasswordController.text.isNotEmpty &&
                                  !_passwordsMatch)
                              ? 'รหัสผ่านไม่ตรงกัน'
                              : null,
                        ),
                        autofillHints: const [AutofillHints.password],
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'โปรดยืนยันรหัสผ่าน';
                        //   }
                        //   if (value != _passwordController.text) {
                        //     return 'รหัสผ่านไม่ตรงกัน';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          String? emailError = validateEmail(_email);
                          String? passwordError = validatePassword(_password);
                          String? confirmPasswordError =
                              validateConfirmPassword(
                                  _confirmPasswordController.text);

                          if (emailError != null ||
                              passwordError != null ||
                              confirmPasswordError != null) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('ข้อมูลไม่ถูกต้อง'),
                                content: Text(
                                    '${emailError ?? ''}\n${passwordError ?? ''}\n${confirmPasswordError ?? ''}'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('ปิด'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            UserCredential? userCredential =
                                await Auth.signUpWithEmailAndPassword(
                                    _email, _password, context);
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
                                                  const ProfilePictureUploadScreen()
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
