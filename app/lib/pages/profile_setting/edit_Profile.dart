import 'package:app/pages/profile.dart';
import 'package:app/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final firestore = FirebaseFirestore.instance;
final currentUser = FirebaseAuth.instance.currentUser;

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String newUsername = "";
  String newEmail = "";
  String newPhoneNumber = "";
  bool isFormValid = false;

  // Function to validate the form
  void validateForm() {
    setState(() {
      isFormValid = newUsername.isNotEmpty && newEmail.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ProfilePageContent(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("Edit Profile",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Username'),
                        prefixIcon: Icon(Icons.person_pin_rounded),
                      ),
                      onChanged: (value) {
                        setState(() {
                          newUsername = value;
                          validateForm();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        prefixIcon: Icon(Icons.email_rounded),
                      ),
                      onChanged: (value) {
                        setState(() {
                          newEmail = value;
                          validateForm();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Phone Number"),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      onChanged: (value) {
                        setState(() {
                          newPhoneNumber = value;
                          validateForm();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isFormValid
                            ? () async {
                                if (currentUser != null) {
                                  await DatabaseFields()
                                      .updateUser(currentUser!.uid, {
                                    'username': newUsername,
                                    'email': newEmail,
                                    'phone_number': newPhoneNumber,
                                  });
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfilePageContent(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (!isFormValid)
                      Text(
                        'All fields are required',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
