import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:urbanpulse/features/Complex/complex_screen.dart';

const double markerSize = 60.0;

class CustomMarker {
  final int id;
  final LatLng location;
  final String title;
  final String category;

  CustomMarker({
    required this.id,
    required this.location,
    required this.title,
    required this.category,
  });

  Future<Marker> createCustomMarker(BuildContext context) async {
    
    String title_show='';
    if(title.length>14){
      title_show=title.substring(0, 15);
    }else{
      title_show=title;
    }
    return Marker(
      rotate: true,
      width: markerSize,
      height: markerSize+80,
      point: location,
      child: GestureDetector(
        onTap: () { 
          Navigator.push(context,MaterialPageRoute(
            builder: (context) => Complex(id: id),
            ),
          );
        },
        child: IntrinsicHeight(
          child: Container(
    
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: markerSize / 2, // Робимо круглий контейнер
                    backgroundImage:  AssetImage("assets/images/profile.jpg"),//MemoryImage(image), // Встановлюємо зображення
                  ),
                  SizedBox(height: 5), // Додайте простір для тексту, якщо потрібно
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black,
                      
                    ),
                    child: Center(
                      child: Text(
                        
                        title_show,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )


      );
  }
}