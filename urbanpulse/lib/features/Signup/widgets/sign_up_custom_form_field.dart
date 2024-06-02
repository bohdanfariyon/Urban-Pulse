import 'package:flutter/material.dart';


Widget CustomTextFormField({
  TextEditingController? controller,
  TextInputType? keyboardType,
  TextInputAction? textInputAction,
  bool obscureText = false,
  String hintText = '',
  IconData? prefixIcon,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      cursorColor: const Color.fromARGB(255, 255, 255, 255),
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.white),
        hintText: hintText,
        prefixIcon: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(prefixIcon),
              ),
            
      ),
    ),
  );
}

