import 'package:flutter/material.dart';
import 'package:urbanpulse/features/Welcome/widgets/login_signup_btn.dart';
import 'package:urbanpulse/features/Welcome/widgets/welcome_image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadAssets(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WelcomeImage(),
                Row(
                  children: [
                    Spacer(),
                    Expanded(
                      flex: 8,
                      child: LoginAndSignupBtn(),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Scaffold( body:Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Future<void> _loadAssets(BuildContext context) async {
    await precacheImage(const AssetImage("assets/images/welcome.png"), context);
  }
}