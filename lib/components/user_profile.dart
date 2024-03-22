import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/views/pictureProfileUpload.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      final PaletteGenerator generator =
          await PaletteGenerator.fromImageProvider(
        NetworkImage(UserData.image),
        size: const Size(200, 200),
      );
      dominantColor = generator.dominantColor?.color;
      AppColor.profileColor = dominantColor;
      textColor = generator.dominantColor?.bodyTextColor;
      AppColor.profileTextColor = textColor;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (UserData.uid.isEmpty || UserData.showProfile == false) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
              child: Stack(
                children: [
                  ValueListenableBuilder<String>(
                    valueListenable: UserData.imageNotifier,
                    builder: (context, imageUrl, _) {
                      return imageUrl.isEmpty
                          ? Container()
                          : Hero(
                              tag: "profileImage",
                              child: Image.network(
                                imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            );
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: UserData.accountType != 'Google'
                        ? GestureDetector(
                            onTap: () {
                              if (mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ProfilePictureUploadScreen()
                                            .animate()
                                            .fade()
                                            .slide(),
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                );
                              }
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      UserData.userName,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor ?? Colors.black,
                      ),
                    ),
                    Text(
                      UserData.email,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: textColor ?? Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
