import 'package:flutter/material.dart';

class RoundedTextForm extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final bool hasSuffix;
  final VoidCallback? onPressed;

  const RoundedTextForm(
      {super.key,
      required this.prefixIcon,
      required this.hintText,
      this.obscureText = false,
      this.hasSuffix = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: const BoxDecoration(
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
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: TextFormField(
            obscureText: obscureText,
            decoration: InputDecoration(
                suffixIcon: hasSuffix
                    ? IconButton(
                        onPressed: onPressed,
                        icon: Icon(obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )
                    : null,
                prefixIcon: Icon(
                  prefixIcon,
                  color: Colors.blue,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 10,
                  color: Color.fromRGBO(131, 143, 160, 100),
                )),
          ),
        ),
      ),
    );
  }
}
