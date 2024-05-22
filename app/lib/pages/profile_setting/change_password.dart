import 'package:app/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
        title: Text("Change Password",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _currentPasswordController,
              obscureText: obscureCurrentPassword,
              decoration: InputDecoration(
                labelText: 'Current Password',
                // suffixIcon: IconButton(
                //   icon: Icon(obscureCurrentPassword
                //       ? Icons.visibility
                //       : Icons.visibility_off),
                //   onPressed: () {
                //     setState(() {
                //       obscureCurrentPassword = !obscureCurrentPassword;
                //     });
                //   },
                // ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
                // suffixIcon: IconButton(
                //   icon: Icon(obscureNewPassword
                //       ? Icons.visibility
                //       : Icons.visibility_off),
                //   onPressed: () {
                //     setState(() {
                //       obscureNewPassword = !obscureNewPassword;
                //     });
                //   },
                // ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                // suffixIcon: IconButton(
                //   icon: Icon(obscureConfirmPassword
                //       ? Icons.visibility
                //       : Icons.visibility_off),
                //   onPressed: () {
                //     setState(() {
                //       obscureConfirmPassword = !obscureConfirmPassword;
                //     });
                //   },
                // ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                side: BorderSide.none,
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                String currentPassword = _currentPasswordController.text;
                String newPassword = _newPasswordController.text;
                String confirmPassword = _confirmPasswordController.text;

                // Validate passwords
                if (newPassword != confirmPassword) {
                  // Show error message or dialog if passwords do not match
                  return;
                }

                // Get current user
                User? currentUser = FirebaseAuth.instance.currentUser;

                if (currentUser != null) {
                  try {
                    // Reauthenticate user
                    AuthCredential credential = EmailAuthProvider.credential(
                        email: currentUser.email!, password: currentPassword);
                    await currentUser.reauthenticateWithCredential(credential);

                    // Update password
                    await currentUser.updatePassword(newPassword);

                    // Show success message or dialog
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Password updated successfully'),
                    ));
                  } catch (e) {
                    // Handle error
                    print('Error updating password: $e');
                    // Show error message or dialog
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Failed to update password'),
                    ));
                  }
                }
              },
              child: const Text('Change Password',
                  style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
