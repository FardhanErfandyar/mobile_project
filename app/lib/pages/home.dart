import 'package:app/pages/homepagecontent.dart';
import 'package:app/pages/inbox.dart';
import 'package:app/pages/profile.dart';
import 'package:app/post/add_field.dart';
import 'package:app/post/post_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/navigation_bar.dart';
import './search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _getBodyWidget(_selectedIndex, context),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _getBodyWidget(int index, BuildContext context) {
    switch (index) {
      case 0:
        return HomePageContent();
      case 1:
        return SearchPageContent();
      case 2:
        return Addfield();
      case 3:
        return PostfieldContent();
      default:
        return ProfilePageContent();
    }
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "Fields",
        style: TextStyle(
            color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0.5,
      actions: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Inbox()),
                  (Route<dynamic> route) => false);
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 37,
              decoration: BoxDecoration(
                  color: const Color(0xffF7F8f8),
                  borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset(
                'assets/icons/inbox-svgrepo-com.svg',
                height: 20,
                width: 18,
              ),
            ))
      ],
    );
  }
}
