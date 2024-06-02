import 'package:flutter/material.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Welcome to UrbanPulse",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16 * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/images/welcome.png",
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 16 * 2),
      ],
    );
  }
}