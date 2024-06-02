import 'package:flutter/material.dart';
import 'package:urbanpulse/router/app_routes.dart';



class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ListTile(
              title: Text('Change password'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.changepassword);
              },
            ),
            Divider(),
            ListTile(
              title: Text('Other'),
              onTap: () {
                // Додайте код для навігації до сторінки з налаштуваннями "Notifications"
              },
            ),
          ],
        ),
      
    );
  }
}
