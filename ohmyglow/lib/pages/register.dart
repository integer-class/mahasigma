import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ohmyglow/pages/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      try {
        final response = await http.post(
          Uri.parse('http://20.190.121.86/api/register'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": name,
            "email": email,
            "password": password,
          }),
        );

        Navigator.pop(context); // Tutup loading indicator

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          if (data["status"] == "success") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Registration successful!")),
            );
            Navigator.pop(
              context,
              new MaterialPageRoute(
                builder: (context) => LoginPage())); // Kembali ke halaman login
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data["message"] ?? "Registration failed.")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to register.")),
          );
        }
      } catch (e) {
        Navigator.pop(context); // Tutup loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sign Up',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 25.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Full name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your full name' : null,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    hintText: 'youremail@gmail.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value!.contains('@') ? null : 'Invalid email address',
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: _togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value!.length >= 6 ? null : 'Password too short',
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: 'Confirm password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) => value == _passwordController.text
                      ? null
                      : 'Passwords do not match',
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _register,
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
