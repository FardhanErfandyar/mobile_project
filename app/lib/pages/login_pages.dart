import 'package:app/pages/home.dart';
import 'package:app/pages/sign_up.dart';
import 'package:app/widgets/rounded_circular_button.dart';
import 'package:app/widgets/rounded_text_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      _loginForm(context),
    ]);
  }

  Widget _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      color: Color.fromARGB(255, 255, 255, 255),
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: const Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              "Sign In",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
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
      height: MediaQuery.of(context).size.height * 0.22,
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
          Text(
            "Forgot Password?",
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.06,
          child: RoundedCircularButton(
            text: "Sign In",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 20,
            bottom: 30,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: Text(
              "I Don't Have An Account",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 102, 102, 102),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
