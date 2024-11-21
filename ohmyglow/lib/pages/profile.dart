import 'package:flutter/material.dart';
import 'package:ohmyglow/pages/editprofile.dart';
import '../config/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: regularTS.copyWith(fontSize: 13, color: Colors.black),
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Awaa",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "20 Years",
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
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Handle notifications setting
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Tell your friend'),
              onTap: () {
                // Handle tell your friend action
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
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Security'),
              onTap: () {
                // Handle security action
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: () {
                // Handle log out action
              },
            ),
          ],
        ),
      ),
    );
  }
}
