import 'package:flutter/material.dart';

class AlsertDialogVerifyEmail extends StatelessWidget {
  const AlsertDialogVerifyEmail({super.key, required this.title, required this.content});
  final String title;
  final String content;
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              title: Text(title),
              
              content: Text(content),
              
              actions: [
                TextButton(
                  child: const Text('OK'),
                  
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
  }
}