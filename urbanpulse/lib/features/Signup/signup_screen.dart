import 'package:flutter/material.dart';
import 'widgets/sign_up_top_image.dart';
import 'widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadAssets(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return  Scaffold(
            appBar: AppBar(
            toolbarHeight: 0,
              
            ),
            body: const SingleChildScrollView(
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SignUpScreenTopImage(),
                  Row(
                    children: [
                      Spacer(),
                      Expanded(
                        flex: 8,
                        child: SignUpForm(),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              )
            ),
          );
        } else {
          return const Scaffold( body:Center(child: CircularProgressIndicator()));
        }
      },
    );
    
  }
  Future<void> _loadAssets(BuildContext context) async {
    await precacheImage(const AssetImage("assets/images/signup.png"), context);
  }
}
