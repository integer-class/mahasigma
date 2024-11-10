import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ohmyglow/pages/Analyst.dart';
import 'package:ohmyglow/pages/history.dart';
import 'package:ohmyglow/pages/home.dart';
import 'package:ohmyglow/pages/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Index of the currently selected item

  // List of widgets for each page
  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    AnalystPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9E0FC),
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Color(0xFF9747FF),
        backgroundColor: Colors.white,
        onTap: _onItemTapped, // Set background color
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/Icons/home.png')
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/Icons/clock.png')
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/Icons/diagram.png')
              ),
              label: 'Analyst',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/Icons/user.png')
              ),
              label: 'Profile',
            ),
          ],
         
        ),
      );
  }
}