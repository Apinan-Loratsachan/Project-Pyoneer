import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pyoneer/service/user_data.dart';
import 'package:pyoneer/utils/color.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Color? dominantColor;
  Color? textColor;

  @override
  void initState() {
    super.initState();
    _updatePaletteGenerator();
  }

  void _updatePaletteGenerator() async {
    if (UserData.image.isNotEmpty) {
      final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
        NetworkImage(UserData.image),
        size: const Size(200, 200),
      );
      dominantColor = generator.dominantColor?.color;
      textColor = generator.dominantColor?.bodyTextColor;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: dominantColor ?? Colors.white70,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: dominantColor ?? AppColor.primarSnakeColor,
              offset: const Offset(0, 10),
              blurStyle: BlurStyle.normal,
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: UserData.image.isEmpty
                  ? Container()
                  : Image.network(UserData.image,),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  UserData.userName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: textColor ?? Colors.black,
                  ),
                ),
                Text(
                  UserData.email,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: textColor ?? Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
