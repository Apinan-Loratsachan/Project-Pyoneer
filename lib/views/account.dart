import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pyoneer/models/user_profile.dart';
import 'package:pyoneer/service/user_data.dart';

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
        title: const Text("Account Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserProfile(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(FontAwesomeIcons.hashtag),
                    title: Text("UID"),
                    trailing: Text("##########"),
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.userPen),
                    title: const Text("Username"),
                    trailing: Text(UserData.userName),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.redAccent),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[500]),
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.rightFromBracket,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Logout",
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
