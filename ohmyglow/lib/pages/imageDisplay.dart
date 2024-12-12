import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageDisplayPage extends StatefulWidget {
  final String imagePath;
  final int diseaseId; // ID untuk mendapatkan detail disease dari API

  const ImageDisplayPage({
    Key? key,
    required this.imagePath,
    required this.diseaseId,
    required String apiResponse,
  }) : super(key: key);

  @override
  _ImageDisplayPageState createState() => _ImageDisplayPageState();
}

class _ImageDisplayPageState extends State<ImageDisplayPage> {
  Map<String, dynamic>? diseaseData;

  @override
  void initState() {
    super.initState();
    fetchDiseaseData();
  }

  Future<void> fetchDiseaseData() async {
    final response = await http.get(
      Uri.parse("http://20.190.121.86/api/diseases/${widget.diseaseId}"),
    );

    if (response.statusCode == 200) {
      setState(() {
        diseaseData = json.decode(response.body)['data'];
      });
    } else {
      // Handle error
      print('Failed to load disease data');
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Skin Diagnostic',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MainScreen()),
              // );
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
        backgroundColor: Colors.transparent,
      ),
      body: diseaseData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Result",
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFFF1507D),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
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
                              SizedBox(height: 20),
                              Text(
                                currentDate,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            height: 200,
                            child: Image.file(File(widget.imagePath)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  diseaseData!['photo_url'] != null
                      ? Image.network(diseaseData!['photo_url'])
                      : Container(),
                  SizedBox(height: 20),
                  Text(
                    diseaseData!['name'] ?? "Unknown Disease",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    diseaseData!['description'] ?? "",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Symptoms",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    diseaseData!['symptoms'] ?? "No symptoms listed.",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Treatment",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    diseaseData!['treatment'] ?? "No treatment listed.",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Cause",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    diseaseData!['cause'] ?? "No cause listed.",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Prevention",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    diseaseData!['prevention'] ?? "No prevention listed.",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "References",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    diseaseData!['references'] ?? "No references available.",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
            ),
    );
  }
}
