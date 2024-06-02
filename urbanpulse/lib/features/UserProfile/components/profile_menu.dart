import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white, padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              
              color: Colors.white,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: TextStyle(color: Colors.white),)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
