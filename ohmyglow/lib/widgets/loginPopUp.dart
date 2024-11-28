import 'package:flutter/material.dart';
import 'package:ohmyglow/pages/login.dart'; // Update the import path as per your project structure

void showLoginPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Login Required"),
        content: const Text("You need to log in to access the Profile page."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the popup
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the popup
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              ); // Navigate to login page
            },
            child: const Text("Login"),
          ),
        ],
      );
    },
  );
}
