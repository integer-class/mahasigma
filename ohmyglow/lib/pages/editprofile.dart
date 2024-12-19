import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:ohmyglow/pages/error.dart';
import 'package:ohmyglow/utils/token_storage.dart';
import 'dart:convert';
import '../config/theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // _loadProfile();
  }

  // Future<void> _loadProfile() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   final token =
  //       await TokenStorage.getToken(); // Retrieve the token from storage
  //   if (token == null) {
  //     print("Token not found!");
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     return;
  //   }

  //   final url =
  //       Uri.parse('http://20.190.121.86/api/profile'); // Correct endpoint
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token', // Pass the token in the header
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     setState(() {
  //       fullNameController.text = data['fullname'] ?? '';
  //       nicknameController.text = data['nickname'] ?? '';
  //       ageController.text = data['age']?.toString() ?? '';
  //       _isLoading = false;
  //     });
  //   } else {
  //     // Handle error
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print('Failed to load profile: ${response.statusCode}');
  //   }
  // }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final fullname = fullNameController.text.trim();
    final nickname = nicknameController.text.trim();
    final age = ageController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      final token = await TokenStorage.getToken();
      if (token == null) {
        _showMessage("Token not found!");
        return;
      }

      final uri = Uri.parse('http://20.190.121.86/api/profile');
      final request = http.MultipartRequest('PATCH', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['fullname'] = fullname
        ..fields['nickname'] = nickname
        ..fields['age'] = age;

      if (_selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('avatar', _selectedImage!.path),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = json.decode(responseBody);
        _showMessage(
            decodedResponse['message'] ?? 'Profile updated successfully');
      } else {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = json.decode(responseBody);
        MaterialPageRoute(
            builder: (context) => MyError(
                error: decodedResponse['errors']
                    .toString())); // Use GuestMainScreen here

        // _showMessage(decodedResponse['errors']?.toString() ??
        //     'Failed to update profile');
      }
    } catch (e) {
      _showMessage('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  final Future<String?> token = TokenStorage.getToken();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: _pickImage,
                    //   child: CircleAvatar(
                    //     radius: 50,
                    //     backgroundImage: _selectedImage != null
                    //         ? FileImage(_selectedImage!)
                    //         : const AssetImage('images/person.png')
                    //             as ImageProvider,
                    //     child: Align(
                    //       alignment: Alignment.bottomRight,
                    //       child: Icon(Icons.add_circle,
                    //           color: Colors.green.shade700),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: nicknameController,
                      decoration: const InputDecoration(
                        labelText: 'Nickname',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your nickname';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _updateProfile,
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
