import 'package:flutter/material.dart';
import 'package:urbanpulse/router/app_routes.dart';



class HelpCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center'),
      ),
      body:ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ListTile(
              title: Text('FAQ'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.faq);
              },
            ),
          ],
        ),
      
    );
  }
}
