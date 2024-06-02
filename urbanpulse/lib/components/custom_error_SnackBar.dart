import 'package:flutter/material.dart';

class CustomErrorSnackBar extends SnackBar {
  CustomErrorSnackBar({super.key, required String errorMessage})
      : super(
          content: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset('assets/gif/gif.gif'), 
              ),
              const SizedBox(width: 10), 
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.white, 
                ),
              ),
            ],
          ),
          backgroundColor: Colors.black, 
        );


  void showSnackBarWithGifAndText(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(this);
  }
}
