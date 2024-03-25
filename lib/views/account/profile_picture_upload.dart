import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image/image.dart' as img;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pyoneer/services/auth.dart';
import 'package:pyoneer/services/user_data.dart';

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
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadProfilePicture() async {
    if (_selectedImage != null && !_isUploading) {
      setState(() {
        _isUploading = true;
      });
      try {
        final resizedImage = await _resizeImage(_selectedImage!, 1024, 1024);
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

        UploadTask uploadTask = storageReference.putFile(resizedImage);
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

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('อัปโหลดรูปภาพโปรไฟล์ของคุณสำเร็จแล้ว')),
          );
          Navigator.of(context).pop();
        }
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
        title: const Text('รูปภาพโปรไฟล์ของคุณ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
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
                    : const SizedBox.shrink(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectImage(ImageSource.gallery),
              child: const Text('เลือกรูปภาพจากแกลเลอรี'),
            ),
            ElevatedButton(
              onPressed: () => _selectImage(ImageSource.camera),
              child: const Text('ถ่ายรูปภาพ'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadProfilePicture,
              child: _isUploading
                  ? SizedBox(
                      width: 50,
                      height: 50,
                      child: LoadingAnimationWidget.stretchedDots(
                        size: 20,
                        color: Colors.white,
                      ),
                    )
                  : const Text('อัปโหลดรูปภาพโปรไฟล์'),
            ),
          ],
        ),
      ),
    );
  }
}
