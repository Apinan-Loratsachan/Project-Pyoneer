import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';
import 'package:pyoneer/views/account/profile_picture_upload.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Color? dominantColor;
  Color? textColor;
  Color? iconColor;
  bool showEditIcon = false;

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
        size: const Size(256, 256),
      );

      final List<Color?> colors = [
        generator.mutedColor?.color,
        generator.dominantColor?.color,
      ];

      final List<Color?> textColors = [
        generator.mutedColor?.titleTextColor,
        generator.dominantColor?.titleTextColor,
      ];

      final random = Random();
      final randomIndex = random.nextInt(colors.length);

      dominantColor = colors[randomIndex] ?? Colors.white70;
      AppColor.profileColor = dominantColor;
      textColor = textColors[randomIndex] ?? Colors.black;
      AppColor.profileTextColor = textColor;
      iconColor = textColors[randomIndex] ?? Colors.grey;

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
      child: GestureDetector(
        onTap: () {
          setState(() {
            showEditIcon = !showEditIcon;
          });
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: dominantColor ?? AppColor.primarSnakeColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: dominantColor ?? AppColor.primarSnakeColor,
                    offset: const Offset(0, 4),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: ValueListenableBuilder<String>(
                      valueListenable: UserData.imageNotifier,
                      builder: (context, imageUrl, _) {
                        return imageUrl.isEmpty
                            ? Container()
                            : Hero(
                                tag: "profileImage",
                                flightShuttleBuilder: (
                                  BuildContext flightContext,
                                  Animation<double> animation,
                                  HeroFlightDirection flightDirection,
                                  BuildContext fromHeroContext,
                                  BuildContext toHeroContext,
                                ) {
                                  return AnimatedBuilder(
                                    animation: animation,
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            animation.value * 8),
                                        child: toHeroContext.widget,
                                      );
                                    },
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                      },
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
            Positioned(
              right: 5,
              top: 5,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: showEditIcon ? 1.0 : 0.0,
                child: UserData.accountType != 'Google' &&
                        UserData.accountType != 'Facebook' &&
                        UserData.accountType != 'ไม่ระบุตัวตน'
                    ? GestureDetector(
                        onTap: () {
                          if (mounted) {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const ProfilePictureUploadScreen()
                                            .animate()
                                            .fade()
                                            .slide(),
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                              ),
                            );
                          }
                        },
                        child: Icon(
                          Icons.edit,
                          color: iconColor ?? Colors.white,
                          size: 20,
                        ),
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
