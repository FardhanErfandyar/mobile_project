import 'dart:io';
import 'package:app/pages/login_pages.dart';
import 'package:app/pages/profile_setting/ProfileMenu.dart';
import 'package:app/pages/profile_setting/change_password.dart';
import 'package:app/pages/profile_setting/edit_Profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class ProfilePageContent extends StatefulWidget {
  ProfilePageContent({Key? key}) : super(key: key);

  @override
  State<ProfilePageContent> createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  final firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser?.email)
        .get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> _uploadImage() async {
    if (selectedImage != null) {
      String fileName = randomAlphaNumeric(10);
      Reference storageRef =
          FirebaseStorage.instance.ref().child("profile_images/$fileName");
      UploadTask uploadTask = storageRef.putFile(selectedImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await firestore.collection("Users").doc(currentUser?.email).update({
        'profileImage': downloadUrl,
      });
      setState(() {
        getUserData().then((userData) {
          userData['profileImage'] ?? "assets/images/ssfix.png";
          // Jangan lupa memanggil setState() agar tampilan diperbarui
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser?.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ' + snapshot.error.toString()),
            );
          }

          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            String profileImageUrl =
                userData['profileImage'] ?? "assets/images/ssfix.png";

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipOval(
                            child: profileImageUrl.startsWith('http')
                                ? Image.network(
                                    profileImageUrl,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    profileImageUrl,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: CupertinoColors.activeOrange,
                              ),
                              child: const Icon(
                                Icons.mode_edit_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userData['username'],
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      userData['email'],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(userData['phone_number'] ?? '',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => UpdateProfileScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CupertinoColors.activeOrange,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ProfileMenu(
                      title: "Change Password",
                      icon: Icons.fingerprint,
                      onPress: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordPage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    ProfileMenu(
                      title: "Logout",
                      icon: Icons.logout,
                      textColor: Colors.red,
                      endIcon: false,
                      onPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("LOGOUT"),
                              content: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Text("Are you sure you want to logout?"),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(child: Text('No user data found.'));
        },
      ),
    );
  }
}
