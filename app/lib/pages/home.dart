import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          _maintext(),
          const SizedBox(
            height: 25,
          ),
          _cards()
        ],
      ),
    );
  }

  Column _cards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          color: Colors.black,
        )
      ],
    );
  }

  Padding _maintext() {
    return const Padding(
        padding: EdgeInsets.only(left: 25, top: 20, right: 25),
        child: Text(
          "Choose your sports facilities",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "Viva Sports",
        style: TextStyle(
            color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: false,
      actions: [
        GestureDetector(
            onTap: () {},
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
