import 'package:flutter/material.dart';
import 'dart:io';

class ImageDisplayPage extends StatelessWidget {
  final String imagePath;

  const ImageDisplayPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Skin Diagnostic',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              print("Save button pressed");
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Your Result",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFF1507D),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Skin",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Problem",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "01 September 2024",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            height: 200,
                            child: Image.file(
                              File(imagePath),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
