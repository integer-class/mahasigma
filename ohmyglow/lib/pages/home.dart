import 'package:flutter/material.dart';
import 'package:ohmyglow/models/item.dart';
import 'package:ohmyglow/pages/camera.dart';
import 'package:ohmyglow/widgets/homePage/profileDashboard.dart';
import 'package:ohmyglow/widgets/homePage/cardMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/theme.dart';

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
  String? username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username'); // Retrieve saved username
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ProfileDashboard(username: username),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8F3CC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set your desired radius
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CameraPage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image: AssetImage("images/logo-face-button.png"),
                          width: 30,
                        ),
                        const SizedBox(width: 13),
                        Text(
                          "Use AI to scan your face",
                          style: regularTS.copyWith(
                              fontSize: 13, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        ImageIcon(
                          AssetImage(
                            'assets/Icons/arrow-right.png',
                          ),
                          color: Colors.black,
                          size: 20,
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 35, 0, 15),
                  child: Row(
                    children: [
                      Text(
                        "Skin Type",
                        style: semiBoldTS.copyWith(
                            fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.start,
                      ),
                    ],
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 35, 0, 15),
                  child: Row(
                    children: [
                      Text(
                        "Skin Problem",
                        style: semiBoldTS.copyWith(
                            fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.start,
                      ),
                    ],
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
              ],
            ),
          ),
        ),
        // ListView.builder(
        //   itemCount: widget.items.length,
        //   scrollDirection: Axis.horizontal,
        //   itemBuilder: (context, index) {
        //     final item = widget.items[index];
        //     return Cardmenu(image: item.image, title: item.title);
        //   },
        // )
      ],
    );
  }
}
