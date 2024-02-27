import 'package:app/pages/home.dart';
import 'package:app/widgets/rounded_circular_button.dart';
import 'package:app/widgets/rounded_text_form.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpLauncher();
}

class _SignUpLauncher extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reenterPasswordController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Column(children: [
      _header(context),
      _SignUp(context),
    ]);
  }

  Widget _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      color: Color.fromARGB(255, 255, 255, 255),
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              "Sign Up!",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _SignUp(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _formField(context),
              _bottomButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formField(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RoundedTextForm(
            prefixIcon: Icons.email_outlined,
            hintText: "Username",
          ),
          RoundedTextForm(
            prefixIcon: Icons.lock_outlined,
            hintText: "Password",
            obscureText: obscureText,
            hasSuffix: true,
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          RoundedTextForm(
            prefixIcon: Icons.lock_person_outlined,
            hintText: "Re-enter your password",
            obscureText: obscureText,
          ),
        ],
      ),
    );
  }

  void onSignUpPressed() {
    if (passwordController.text == reenterPasswordController.text) {
    } else {}
  }

  Widget _bottomButtons(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.06,
                child: const RoundedCircularButton(
                  text: "Sign Up",
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
