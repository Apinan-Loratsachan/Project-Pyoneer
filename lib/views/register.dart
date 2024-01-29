import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
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
  bool _obscureText2 = true;
  bool _isFieldEmpty = true;
  bool _isFieldEmpty2 = true;
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  bool _passwordsMatch = false;
  bool _hasInteractedWithField2 = false;

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
    _fadeController.forward();
    _slideController.forward();
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
    _fadeController.dispose();
    _slideController.dispose();
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
                  SlideTransition(
                    position: _iconSlideAnimation,
                    child: FadeTransition(
                      opacity: _iconFadeAnimation,
                      child: Image.asset(
                        'assets/icons/pyoneer_bg_less.png',
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
                  SlideTransition(
                    position: _formSlideAnimation,
                    child: FadeTransition(
                      opacity: _formFadeAnimation,
                      // child: const Text(
                      //   'REGISTER',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 24,
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SlideTransition(
                    position: _formSlideAnimation,
                    child: FadeTransition(
                      opacity: _formFadeAnimation,
                      child: TextFormField(
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
                    ),
                  ),
                  const SizedBox(height: 24),
                  SlideTransition(
                    position: _formSlideAnimation,
                    child: FadeTransition(
                      opacity: _formFadeAnimation,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle sign up logic
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              const Color(0xFF1ABDAD), // Text color
                        ),
                        child: const Text('สมัครสมาชิก'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // SlideTransition(
                  //   position: _threePartySlideAnimation,
                  //   child: FadeTransition(
                  //       opacity: _threePartyFadeAnimation,
                  //       child: const Center(child: Text('OR'))),
                  // ),
                  // const SizedBox(height: 16),
                  // SlideTransition(
                  //   position: _threePartySlideAnimation,
                  //   child: FadeTransition(
                  //     opacity: _threePartyFadeAnimation,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: <Widget>[
                  //         IconButton(
                  //           icon: const FaIcon(FontAwesomeIcons.google),
                  //           onPressed: () {
                  //             // Handle Google login
                  //           },
                  //           color: Colors.blue[500],
                  //         ),
                  //         IconButton(
                  //           icon: const FaIcon(FontAwesomeIcons.facebook),
                  //           onPressed: () {
                  //             // Handle Facebook login
                  //           },
                  //           color: Colors.blue,
                  //         ),
                  //         IconButton(
                  //           icon: const FaIcon(FontAwesomeIcons.line),
                  //           onPressed: () {
                  //             // Handle LinkedIn login
                  //           },
                  //           color: Colors.green[300],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      // Navigate to login page
                      Navigator.pop(context);
                    },
                    child: SlideTransition(
                      position: _threePartySlideAnimation,
                      child: FadeTransition(
                        opacity: _threePartyFadeAnimation,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: 'มีบัญชีอยู่แล้ว? ',
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'ลงชื่อเข้าใช้',
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
