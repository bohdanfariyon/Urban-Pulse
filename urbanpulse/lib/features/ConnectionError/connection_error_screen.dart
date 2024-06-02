import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConnectionErrorScreen extends StatefulWidget {
  const ConnectionErrorScreen({Key? key});

  @override
  State<ConnectionErrorScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(201, 150, 149, 149),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/gif/no_connection.json',
            height: 300,
          ),
          Center(
            child: Text(
              "No Connection".toUpperCase(),
              style: TextStyle(
                fontSize: 30,
                shadows: [
                  Shadow(color: Colors.black38, offset: const Offset(1, 1)),
                ],
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
