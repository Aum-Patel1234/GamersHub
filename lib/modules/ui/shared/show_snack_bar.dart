import 'dart:async';

import 'package:flutter/material.dart';
import '../screens/application.dart';

Future<void> showCustomSnackBar({required String message}) async {
  await Future.delayed(const Duration(seconds: 1));

  final isDarkMode = Theme.of(scaffoldMessengerKey.currentContext!).brightness == Brightness.dark;

  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black, // Text color based on theme
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: isDarkMode ? Colors.black87 : Colors.blueAccent, // Background color based on theme
    duration: const Duration(seconds: 4), 
    behavior: SnackBarBehavior.floating, 
    shape: RoundedRectangleBorder( 
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.all(16), 
  );

  // Show the snackbar
  scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}

Future<void> handleApiResponse(List<dynamic> response) async {
  // Check if the response contains the error codes and display appropriate messages
  int statusCode = response.first['status'] ?? 0;
  
  String message;
  
  switch (statusCode) {
    case 400:
      message = 'Bad Request: ${response.first['example']}';
      break;
    case 401:
      message = 'Authorization Failure: ${response.first['message']}';
      break;
    case 403:
      message = 'Forbidden: ${response.first['details']}';
      break;
    case 404:
      message = 'Not Found: ${response.first['title']}';
      break;
    default:
      message = 'An unknown error occurred.';
      break;
  }

  // Show the message in the snackbar
  await showCustomSnackBar(message: message);
}