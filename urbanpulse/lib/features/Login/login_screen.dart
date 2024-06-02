import 'package:flutter/material.dart';
import 'widgets/login_form.dart';
import 'widgets/login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadAssets(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0, 
            ),
            body:SingleChildScrollView(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const LoginScreenTopImage(),
                  Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 8,
                        child: LoginForm(),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold( body:Center(child: CircularProgressIndicator()));
        }
      },
    );
    
    
  }
  Future<void> _loadAssets(BuildContext context) async {
    await precacheImage(const AssetImage("assets/images/login.png"), context);
  }
}

