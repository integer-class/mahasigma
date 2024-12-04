import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:ohmyglow/mainScreen.dart';
import 'package:ohmyglow/widgets/camera/progressBar.dart';
import 'package:ohmyglow/widgets/camera/resultCard.dart';
import '../config/theme.dart';

class ImageDisplayPage extends StatelessWidget {
  final String imagePath;
  final List<dynamic>? recognitions;

  const ImageDisplayPage(
      {super.key, required this.imagePath, this.recognitions, required String apiResponse});

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    double acneConfidence = 0.75;
    double oilyConfidence = 0.50;
    double blackheadConfidence = 0.35;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Skin Diagnostic',
          style: regularTS.copyWith(fontSize: 18, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
            child: Text(
              "Save",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          )
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
                                  currentDate,
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
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    progressBar(label: "Acne", value: acneConfidence),
                    progressBar(label: "Blackhead", value: blackheadConfidence),
                    progressBar(label: "Oily", value: oilyConfidence)
                  ],
                ),
              ),
              if (recognitions != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: recognitions!.length,
                    itemBuilder: (context, index) {
                      var result = recognitions![index];
                      return ListTile(
                        title: Text("${result["label"]}"),
                        subtitle: Text(
                            "Confidence: ${(result["confidence"] * 100).toStringAsFixed(2)}%"),
                      );
                    },
                  ),
                ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  resultCard(
                      image: "images/water.png", title: "Drink More Water"),
                  resultCard(image: "images/meal.png", title: "Healthy diet")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
