import 'package:app/pages/home.dart';
import 'package:app/widgets/rounded_circular_button.dart';
import 'package:app/widgets/rounded_text_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpLauncher();
}

class _SignUpLauncher extends State<SignUp> {
  String username = "";
  String email = "";
  String password = "";
  String reenterPassword = "";

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController reenterPasswordController = new TextEditingController();
  bool obscureText = true;
  final firestore = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null &&
        usernameController.text != "" &&
        emailController.text != "" &&
        passwordController.text != "" &&
        reenterPasswordController.text != "") {
      // create the user
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // create new document for cloud firestore
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set({
          'username': usernameController.text,
          'email': emailController.text,
          'uid': userCredential.user!.uid
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'Sign Up berhasil',
          style: TextStyle(fontSize: 20.0),
        )));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.amber,
              content: Text(
                'Akun sudah terdaftar',
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              )));
        }
      }
    }
  }

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
                color: Color.fromARGB(255, 251, 168, 52),
                fontWeight: FontWeight.w600,
                fontSize: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Masukkan Username";
    }
    return null;
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

  String? validateReenterPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Masukkan Password ulang";
    }
    if (value != passwordController.text) {
      return "Password tidak sama";
    }
    return null;
  }

  Widget _SignUp(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.70,
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
      height: MediaQuery.of(context).size.height * 0.28,
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              validator: validateUsername,
              controller: usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.black,
                ),
                hintText: "Username",
              ),
            ),
            TextFormField(
              validator: validateEmail,
              controller: emailController,
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
              controller: passwordController,
              obscureText: obscureText,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outlined),
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
            ),
            TextFormField(
              validator: validateReenterPassword,
              controller: reenterPasswordController,
              obscureText: obscureText,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_person_outlined),
                hintText: "Re-enter your password",
              ),
            ),
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
                username = usernameController.text;
                email = emailController.text;
                password = passwordController.text;
                reenterPassword = reenterPasswordController.text;
              });
              registration();
            }
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
                "Sign Up",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
