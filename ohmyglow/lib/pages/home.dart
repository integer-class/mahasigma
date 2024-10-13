import 'package:flutter/material.dart';
import 'package:ohmyglow/models/item.dart';
import 'package:ohmyglow/widgets/homePage/cardDashboard.dart';
import 'package:ohmyglow/widgets/homePage/cardMenu.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final List<Item> items = [
    Item(image: 'images/nose.png', title: "Blackhead"),
    Item(image: 'images/jerawat.png', title: "Eczema"),
    Item(image: 'images/jerawat.png', title: "Anu")
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Index of the currently selected item

  // List of widgets for each page
  final List<Widget> _pages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Activity Page')),
    Center(child: Text('Analytics Page')),
    Center(child: Text('Profile Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardDashboard,
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                "How is Your Face Skin Today?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD14D72)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Skin Problem",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Cardmenu(
                      image: widget.items[0].image,
                      title: widget.items[0].title),
                  Cardmenu(
                      image: widget.items[1].image,
                      title: widget.items[1].title),
                  Cardmenu(
                      image: widget.items[2].image,
                      title: widget.items[2].title),
                ],
              ),
            )
            // ListView.builder(
            //   itemCount: widget.items.length,
            //   scrollDirection: Axis.horizontal,
            //   itemBuilder: (context, index) {
            //     final item = widget.items[index];
            //     return Cardmenu(image: item.image, title: item.title);
            //   },
            // )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.green[100], // Set background color
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '', // Empty label for Home
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: '', // Empty label for Activity
            ),
            BottomNavigationBarItem(
              icon: SizedBox.shrink(), // Empty space for center button
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              label: '', // Empty label for Analytics
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '', // Empty label for Profile
            ),
          ],
          currentIndex: _selectedIndex, // Current selected index
          selectedItemColor: Colors.black, // Color of the selected item
          unselectedItemColor: Colors.grey, // Color of the unselected items
          onTap: _onItemTapped, // Function called when an item is tapped
          type: BottomNavigationBarType.fixed, // For fixed layout
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the center button
        },
        backgroundColor: Colors.green, // Set button color
        child: const Icon(Icons.face), // Center button icon
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // Position the FAB
    );
  }
}
