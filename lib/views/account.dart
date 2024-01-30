import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/models/user_profile.dart';
import 'package:pyoneer/service/auth.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/views/login.dart';

class AccountSettigScreen extends StatefulWidget {
  const AccountSettigScreen({super.key});

  @override
  State<AccountSettigScreen> createState() => _AccountSettigScreenState();
}

class _AccountSettigScreenState extends State<AccountSettigScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("การตั้งค่าบัญชี"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UserProfile(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.hashtag),
                    title: const Text("รหัสผู้ใช้"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UserData.uid == 'ไม่ได้เข้าสู่ระบบ' ||
                                UserData.uid == '' || UserData.uid.isEmpty
                            ? Container()
                            : IconButton(
                                onPressed: () async {
                                  await Clipboard.setData(
                                      ClipboardData(text: UserData.uid));
                                  Fluttertoast.showToast(
                                      msg: "คัดลอก UID แล้ว");
                                },
                                icon: const Icon(Icons.copy),
                                iconSize: 20,
                              ),
                        Text(UserData.uid),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.userPen),
                    title: const Text("ชื่อผู้ใช้"),
                    trailing: Text(UserData.userName),
                  ),
                  ListTile(
                    leading: const Icon(Icons.mail),
                    title: const Text("อีเมล"),
                    trailing:
                        Text(UserData.email == '' ? 'ไม่ทราบ' : UserData.email),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text("เบอร์โทรศัพท์"),
                    trailing:
                        Text(UserData.tel == '' ? 'ไม่ทราบ' : UserData.tel),
                  ),
                  ListTile(
                      leading: const Icon(Icons.link),
                      title: const Text("ประเภทบัญชี"),
                      trailing: UserData.getLoginProviderIcon()),
                  ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.redAccent),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[500]),
                    ),
                    onPressed: () async {
                      showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          title: const Text('ยืนยันการออกจากระบบ'),
                          content:
                              const Text('คุณต้องการออกจากระบบใช่หรือไม่?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('ยกเลิก',
                                  style: TextStyle(color: Colors.black)),
                            ),
                            TextButton(
                              onPressed: () {
                                UserData.clear();
                                Auth.signOut();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const LoginScreen(),
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      transitionsBuilder: (context, animation1,
                                          animation2, child) {
                                        animation1 = CurvedAnimation(
                                          parent: animation1,
                                          curve: Curves.easeInOut,
                                        );
                                        return FadeTransition(
                                          opacity: Tween(begin: 0.0, end: 1.0)
                                              .animate(animation1),
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
                                    (Route<dynamic> route) => false);
                              },
                              child: const Text('ออกจากระบบ',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.rightFromBracket,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "ออกจากระบบ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
