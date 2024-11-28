import 'package:flutter/material.dart';
import 'package:ohmyglow/pages/guestHome.dart';
import 'package:ohmyglow/widgets/loginPopUp.dart';

class GuestMainScreen extends StatefulWidget {
  const GuestMainScreen({super.key});

  @override
  State<GuestMainScreen> createState() => _GuestMainScreenState();
}

class _GuestMainScreenState extends State<GuestMainScreen> {
  int _selectedIndex = 0; // Index of the currently selected item

  // List of widgets for each page
  final List<Widget> _pages = [
    GuestHomePage(),
    const Center(
      child: Text("History Page Placeholder"), // Placeholder for Profile page
    ),
    const Center(
      child: Text("Profile Page Placeholder"), // Placeholder for Profile page
    )
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // If the user taps the Profile icon
      showLoginPopup(context); // Show the login popup();
    } else if (index == 1) {
      showLoginPopup(context);
    } else {
      setState(() {
        _selectedIndex = index; // Update the selected index
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE9E0FC),
      body: _selectedIndex == 2
          ? const Center(
              child: Text("Please log in to access the Profile page."),
            )
          : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: const Color(0xFF9747FF),
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/Icons/home.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/Icons/clock.png')),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/Icons/user.png')),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
