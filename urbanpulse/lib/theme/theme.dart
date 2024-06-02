import 'package:flutter/material.dart';

final darkTheme = ThemeData(
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white, // Колір індикатора
          circularTrackColor: Colors.black, // Колір треку для кругового індикатора
        ),
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
          scaffoldBackgroundColor: const Color.fromARGB(201, 150, 149, 149),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Color.fromARGB(255, 0, 0, 0),
            iconColor: Color.fromARGB(255, 255, 255, 255),
            prefixIconColor: Color.fromARGB(255, 255, 255, 255),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )
);