import 'package:flutter/material.dart';
import 'package:urbanpulse/features/Partners/partners_screen.dart';
import 'package:urbanpulse/features/UserProfile/user_profile_screen.dart';
import 'package:urbanpulse/features/Map/map_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        child: GNav(
          backgroundColor: Colors.transparent,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 20,
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          padding: EdgeInsets.all(16),
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.map, text: 'Map'),
            GButton(icon: Icons.person, text: 'Profile'),
          ],
        ),
      ),
      extendBody: true, 
    );
  }

  final pages = [
    PartnersScreen(),
    MapScreen(),
    UserProfileScreen(),
  ];
}

