import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  List<int> items = List<int>.generate(100, (int index) => index);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/back-svgrepo-com.svg',
                    height: 20,
                    width: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Inbox",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: items.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              background: Container(
                color: Colors.red,
              ),
              key: ValueKey<int>(items[index]),
              onDismissed: (DismissDirection direction) {
                setState(() {
                  items.removeAt(index);
                });
              },
              child: ListTile(
                title: Text(
                  'Item ${items[index]}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
