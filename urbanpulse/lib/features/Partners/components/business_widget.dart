import 'package:flutter/material.dart';
import 'package:urbanpulse/features/Complex/complex_screen.dart';


class BusinessWidget extends StatelessWidget {
  final int id;
  final String businessName;
  final String category;
  final int distance;

  BusinessWidget({
    required this.id,
    required this.businessName,
    required this.category,
    required this.distance,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
              Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Complex(id: id),
        ),
      );


      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(5),
        child: Stack(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
              title: Text(
                businessName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category),
                  SizedBox(height: 5),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Text('Distance: $distance m', textAlign: TextAlign.end),
            ),
          ],
        ),
      ),
    );
  }
}
