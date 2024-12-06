import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
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
  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://20.190.121.86/api/profile'),
        headers: {'Authorization': 'Bearer YOUR_ACCESS_TOKEN'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          fullNameController.text = data['fullname'] ?? '';
          nicknameController.text = data['nickname'] ?? '';
          ageController.text = data['age']?.toString() ?? '';
          emailController.text = data['email'] ?? '';
          // Load avatar if exists
          if (data['avatar'] != null) {
            _selectedImage = File(data['avatar']);
          }
        });
      } else {
        _showMessage('Failed to load profile');
      }
    } catch (e) {
      _showMessage('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final uri = Uri.parse('http://20.190.121.86/api/profile');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer YOUR_ACCESS_TOKEN'
        ..fields['fullname'] = fullNameController.text
        ..fields['nickname'] = nicknameController.text
        ..fields['age'] = ageController.text
        ..fields['email'] = emailController.text;

      if (_selectedImage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('avatar', _selectedImage!.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        _showMessage('Profile updated successfully');
      } else {
        _showMessage('Failed to update profile');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : const AssetImage('images/person.png')
                              as ImageProvider,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(Icons.add_circle,
                            color: Colors.green.shade700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nicknameController,
                    decoration: const InputDecoration(
                      labelText: 'Nickname',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateProfile,
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
    );
  }
}
