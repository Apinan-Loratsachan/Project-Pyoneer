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
      body: Column(
        children: [
          UserProfile(),
          ListTile(
            leading: Icon(FontAwesomeIcons.userPen),
            title: Text("Name"),
            trailing: Text(UserData.userName),
          )
        ],
      ),
    );
  }
}