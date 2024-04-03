import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image/image.dart' as img;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pyoneer/services/auth.dart';
import 'package:pyoneer/services/user_data.dart';
import 'package:pyoneer/utils/color.dart';

class ProfilePictureUploadScreen extends StatefulWidget {
  const ProfilePictureUploadScreen({super.key});

  @override
  _ProfilePictureUploadScreenState createState() =>
      _ProfilePictureUploadScreenState();
}

class _ProfilePictureUploadScreenState
    extends State<ProfilePictureUploadScreen> {
  File? _selectedImage;
  String? _currentProfilePictureUrl;
  bool _isUploading = false;
  bool _isPickerActive = false;

  @override
  void initState() {
    super.initState();
    _fetchCurrentProfilePicture();
  }

  Future<void> _fetchCurrentProfilePicture() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentProfilePictureUrl = user.photoURL;
      });
    }
  }

  Future<void> _selectImage(ImageSource source) async {
    if (!_isPickerActive) {
      setState(() {
        _isPickerActive = true;
      });

      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'เลือกสัดส่วนรูปภาพ',
              toolbarColor: AppColor.primarSnakeColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              showCropGrid: true,
              hideBottomControls: true,
              activeControlsWidgetColor: AppColor.primarSnakeColor,
            ),
            IOSUiSettings(
              title: 'เลือกสัดส่วนรูปภาพ',
            ),
          ],
        );
        if (croppedFile != null) {
          File resizedImage =
              await _resizeImage(File(croppedFile.path), 512, 512);
          setState(() {
            _selectedImage = resizedImage;
          });
        }
      }

      setState(() {
        _isPickerActive = false;
      });
    }
  }

  Future<void> _uploadProfilePicture() async {
    if (_selectedImage != null && !_isUploading) {
      setState(() {
        _isUploading = true;
      });
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        FirebaseStorage.instance
            .setMaxUploadRetryTime(const Duration(seconds: 3));
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('user_profiles')
            .child('$userId.jpg');

        bool imageExists = await storageReference
            .getMetadata()
            .then((_) => true)
            .catchError((_) => false);

        UploadTask uploadTask = storageReference.putFile(_selectedImage!);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        await FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadURL);
        setState(() {
          _currentProfilePictureUrl = downloadURL;
        });
        await UserData.updateUserImage(downloadURL);

        if (!imageExists) {
          await UserData.clear();
          await Auth.signOut();
        }

        // if (mounted) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //         content: Text('อัปโหลดรูปภาพโปรไฟล์ของคุณสำเร็จแล้ว')),
        //   );
        //   Navigator.of(context).pop();
        // }
        Navigator.of(context).pop(imageExists);
      } catch (e) {
        if (kDebugMode) {
          print('Error uploading profile picture: $e');
        }
        AlertDialog(
          title: const Text('อัปโหลดรูปภาพโปรไฟล์ของคุณไม่สำเร็จ'),
          content: const Text('เกิดข้อผิดพลาดในการอัปโหลดรูปภาพโปรไฟล์ของคุณ'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ตกลง'),
            ),
          ],
        );
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Future<File> _resizeImage(File imageFile, int width, int height) async {
    final image = img.decodeImage(await imageFile.readAsBytes());
    final resizedImage = img.copyResize(image!, width: width, height: height);
    final resizedFile = File(imageFile.path)
      ..writeAsBytesSync(img.encodeJpg(resizedImage));
    return resizedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('รูปภาพโปรไฟล์ของคุณ'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: _selectedImage != null
                  ? Image.file(
                      _selectedImage!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : _currentProfilePictureUrl != null
                      ? Image.network(
                          _currentProfilePictureUrl!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.person,
                          size: 200,
                          color: Colors.grey,
                        ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _isPickerActive || _isUploading
                    ? null
                    : () => _selectImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('เลือกรูปภาพ'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _isPickerActive || _isUploading
                    ? null
                    : () => _selectImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text('ถ่ายรูปภาพ'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isUploading ? null : _uploadProfilePicture,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 15,
              ),
            ),
            child: SizedBox(
              width: 200,
              height: 24,
              child: _isUploading
                  ? Center(
                      child: LoadingAnimationWidget.stretchedDots(
                        size: 24,
                        color: Colors.white,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload),
                        SizedBox(width: 8),
                        Text('อัปโหลดรูปภาพโปรไฟล์'),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
