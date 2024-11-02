import 'package:flutter/material.dart';
import 'package:ohmyglow/models/item.dart';
import 'package:ohmyglow/pages/camera.dart';
import 'package:ohmyglow/widgets/homePage/profileDashboard.dart';
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: profileDashboard),
          Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70),
                topRight: Radius.circular(70),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC8F3CC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), // Set your desired radius
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CameraPage()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                              image: AssetImage("images/logo-face-button.png")),
                          Text(
                            "Use AI to scan your face",
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(
                            Icons.navigate_next_sharp,
                            color: Colors.black,
                          )
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 35, 0, 15),
                    child: Row(
                      children: [
                        Text(
                          "Skin Type",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 35, 0, 15),
                    child: Row(
                      children: [
                        Text(
                          "Skin Problem",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }
}
