import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  final IconData prefixIcon;
  final String hintText;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction; 

  const CustomTextField({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    this.obscureText = false,
    required this.onChanged,
    required this.textInputAction, 
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color:Colors.white),
      controller: _controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      cursorColor: const Color.fromARGB(255, 255, 255, 255),
      textInputAction: widget.textInputAction, 
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(widget.prefixIcon),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
