import 'package:flutter/material.dart';

class CustomFiledInput extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String hintText;
  final IconData prefixIcon;
  

  const CustomFiledInput({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
    required this.hintText,
    required this.prefixIcon,
    
  }) : super(key: key);

  @override
  _CustomFiledInputState createState() => _CustomFiledInputState();
}

class _CustomFiledInputState extends State<CustomFiledInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        style: TextStyle(color:Colors.white),
        cursorColor: Colors.white,
        
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          hintText: widget.hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(widget.prefixIcon),
          ),
        ),
      ),
    );
  }
}
