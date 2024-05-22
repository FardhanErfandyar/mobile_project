import 'package:app/pages/forgot_password.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/homepagecontent.dart';
import 'package:app/pages/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              'Akun belum terdaftar',
              style: TextStyle(fontSize: 20),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.amber,
          content: Text(
            'Password salah',
            style: TextStyle(fontSize: 20),
          ),
        ));
      }
    }
  }

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
                color: Color.fromARGB(255, 251, 168, 52),
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Masukkan Email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Masukkan Password";
    }
    return null;
  }

  Widget _formField(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.22,
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              validator: validateEmail,
              controller: emailcontroller,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                hintText: "Email",
              ),
            ),
            TextFormField(
              validator: validatePassword,
              controller: passwordcontroller,
              obscureText: obscureText,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outlined),
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text(
                "Sign In As a Guest",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              setState(() {
                email = emailcontroller.text;
                password = passwordcontroller.text;
              });
            }

            userLogin();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 251, 168, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.06,
            child: const Center(
              child: Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Colors.white),
              ),
            ),
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
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
