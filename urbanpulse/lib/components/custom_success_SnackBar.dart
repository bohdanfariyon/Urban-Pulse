import 'package:flutter/material.dart';

class CustomSuccessSnackBar extends SnackBar {
  CustomSuccessSnackBar({super.key, required String successMessage})
      : super(
          content: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green, // Колір для іконки успіху
              ),
              const SizedBox(width: 10), // Пропустити трохи місця між іконкою і текстом
              Text(
                successMessage,
                style: const TextStyle(
                  color: Colors.white, // Колір тексту
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green, // Колір фону повідомлення
        );
}
