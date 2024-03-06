import 'package:app/models/category_model.dart';
import 'package:app/pages/homepagecontent.dart';
import 'package:app/pages/inbox.dart';
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
      default:
        return Container();
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
      centerTitle: false,
      actions: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Inbox()),
              );
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
