import 'package:flutter/material.dart';

class RoundedCircularButton extends StatefulWidget {
  final String text;

  const RoundedCircularButton({
    super.key,
    required this.text,
    required Null Function() onPressed,
  });

  @override
  State<RoundedCircularButton> createState() => _RoundedCircularButtonState();
}

class _RoundedCircularButtonState extends State<RoundedCircularButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 102, 102, 102),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            100,
          ),
        ),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
