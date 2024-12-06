import 'dart:convert';

import 'package:ohmyglow/utils/token_storage.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchUserData() async {
  final token = await TokenStorage.getToken(); // Retrieve the stored token

  if (token == null) {
    print("Token not found!");
    return null;
  }

  try {
    final response = await http.get(
      Uri.parse('http://20.190.121.86/api/user'), // Replace with your endpoint
      headers: {
        "Authorization": "Bearer $token", // Pass the token in the header
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return user data
    } else {
      print("Failed to fetch user data: ${response.body}");
      return null;
    }
  } catch (e) {
    print("Error fetching user data: $e");
    return null;
  }
}
