import 'package:flutter/material.dart';


class PasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputAction textInputAction;

  PasswordFormField({
    required this.controller,
    required this.hintText,
    this.obscureText = true,
    required this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        textInputAction: textInputAction,
        obscureText: obscureText,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(Icons.lock),
          ),
        ),
      ),
    );
  }
}

