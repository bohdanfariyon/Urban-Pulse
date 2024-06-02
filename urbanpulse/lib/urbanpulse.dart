import 'package:flutter/material.dart';
import 'package:urbanpulse/router/app_routes.dart';
import 'package:urbanpulse/theme/theme.dart';

class UrbanPulse extends StatelessWidget {
  const UrbanPulse({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UrbanPulse',
      theme: darkTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.pages,
    );
  }
}