import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ohmyglow/pages/descriptionPage.dart';
import 'package:ohmyglow/utils/token_storage.dart';
import 'package:ohmyglow/widgets/homePage/cardMenu.dart';
import 'package:ohmyglow/widgets/loginPopUp.dart';
import 'package:http/http.dart' as http;
import '../config/theme.dart';

class GuestHomePage extends StatefulWidget {
  GuestHomePage({
    super.key,
  });

  @override
  State<GuestHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<GuestHomePage> {
  List<dynamic> _diseaseData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDisease();
  }

  Future<void> _fetchDisease() async {
    final url = Uri.parse('http://20.190.121.86/api/diseases');
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _diseaseData = data['data']; // Ensure this matches your API response
        _isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        _isLoading = false;
      });
      print('Failed to load history: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Image.asset("images/logoSplash.png", width: 130),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 1.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC8F3CC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                  ),
                  onPressed: () {
                    showLoginPopup(context);
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
                      const SizedBox(width: 13),
                      ImageIcon(
                        AssetImage('assets/Icons/arrow-right.png'),
                        color: Colors.black,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 35, 0, 15),
                  child: Row(
                    children: [
                      Text(
                        "Skin Diseases",
                        style: semiBoldTS.copyWith(
                            fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                          ),
                          itemCount: _diseaseData.length,
                          itemBuilder: (context, index) {
                            final item = _diseaseData[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DescriptionPage(diseaseId: item['id']),
                                  ),
                                );
                              },
                              child: Cardmenu(
                                image: item['photo'],
                                title: item['name'],
                              ),
                            );
                          },
                        ),
                      ),
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
