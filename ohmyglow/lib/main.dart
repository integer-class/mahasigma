import 'package:flutter/material.dart';
import 'package:ohmyglow/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      body: HomePage(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
