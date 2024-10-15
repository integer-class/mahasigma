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
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    image: widget.items[0].image, title: widget.items[0].title),
                Cardmenu(
                    image: widget.items[1].image, title: widget.items[1].title),
                Cardmenu(
                    image: widget.items[2].image, title: widget.items[2].title),
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
    );
  }
}
