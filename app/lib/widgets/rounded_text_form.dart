import 'package:flutter/material.dart';

class RoundedTextForm extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final bool hasSuffix;
  final VoidCallback? onPressed;
  final TextEditingController controller;

  const RoundedTextForm({
    Key? key,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
    this.hasSuffix = false,
    this.onPressed,
    required this.controller,
    required String? Function(dynamic value) validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(67, 71, 77, 0.08),
            spreadRadius: 10,
            blurRadius: 40,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              prefixIcon: Icon(
                prefixIcon,
                color: Colors.blue,
              ),
              suffixIcon: hasSuffix
                  ? IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                  : null,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 10,
                color: Color.fromRGBO(131, 143, 160, 100),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
