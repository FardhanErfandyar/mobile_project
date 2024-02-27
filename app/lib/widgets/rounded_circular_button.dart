import 'package:flutter/material.dart';

class RoundedCircularButton extends StatelessWidget {
  final String text;

  const RoundedCircularButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 102, 102, 102),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            100,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
