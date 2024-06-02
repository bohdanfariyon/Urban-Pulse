import 'package:flutter/material.dart';
import 'package:urbanpulse/config/app_color.dart';
import 'package:urbanpulse/router/app_routes.dart';




class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
              ),
            onPressed: () { 
              Navigator.of(context).pushNamed(AppRoutes.login);
            },
            child: const Text(
              "LOGIN",
              style: TextStyle(color: buttonTextColor),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
              ),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.signup);
          },
          
          child: const Text(
            "SIGN UP",
            style: TextStyle(color: buttonTextColor),
          ),
        ),
      ],
    );
  }
}
