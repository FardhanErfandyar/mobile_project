import 'package:app/firebase_options.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/login_pages.dart';
import 'package:app/pages/sign_up.dart';
import 'package:app/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Poppins'),
            initialRoute: '/login',
            routes: {
              '/': (context) => HomePage(),
              '/login': (context) => LoginPage(),
              '/signup': (context) => SignUp()
            },
          );
        }
      },
    );
  }
}
