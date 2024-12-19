import 'package:flutter/material.dart';
import 'package:ohmyglow/data/responses/fetchUserData.dart';
import 'package:ohmyglow/main.dart';
import 'package:ohmyglow/pages/editprofile.dart';
import 'package:ohmyglow/utils/token_storage.dart';
import '../config/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Map<String, dynamic>?>? _userDataFuture;

  Future<void> logout() async {
    await TokenStorage.deleteToken();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  @override
  void initState() {
    super.initState();
    _userDataFuture = fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show a loader
          }

          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text("Failed to load user data."),
            );
          }

          final userData = snapshot.data!;
          final username = userData['name'];
          final email = userData['email'];

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: boldTS.copyWith(color: Colors.black),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('images/person.png'),
                      ),
                      SizedBox(width: 16.0),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit profile'),
                    onTap: () {
                      // Navigasi ke halaman EditProfilePage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.feedback),
                    title: Text('Feedback'),
                    onTap: () {
                      // Handle feedback action
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Help & Support'),
                    onTap: () {
                      // Handle help and support action
                    },
                  ),
                  Spacer(),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log out'),
                    onTap: () {
                      // Handle log out action
                      logout();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
