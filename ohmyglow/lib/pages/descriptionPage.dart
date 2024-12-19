import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/theme.dart';

class DescriptionPage extends StatelessWidget {
  final int diseaseId;

  const DescriptionPage({Key? key, required this.diseaseId}) : super(key: key);

  Future<Map<String, dynamic>> fetchDiseaseDetail() async {
    final response = await http.get(
      Uri.parse('http://20.190.121.86/api/diseases/$diseaseId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load disease details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDiseaseDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final disease = snapshot.data!;

          return Container(
            height: double.infinity,
            color: Color(0xffE9E0FC),
            child: Stack(children: [
              Image.asset(
                disease['photo'] ?? '',
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Center(child: Text('Image not available')),
                  );
                },
              ),
              Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ))),
              Positioned(
                top: 280,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          disease['name'] ?? 'Unknown Disease',
                          style: semiBoldTS.copyWith(
                              fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text(
                          disease['description'] ?? 'No description available',
                          style: regularTS.copyWith(
                              fontSize: 14, color: Colors.black87),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Symptoms",
                          style: semiBoldTS.copyWith(
                              fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text(
                          disease['symptoms'] ?? 'No symptoms available',
                          style: regularTS.copyWith(
                              fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Cause",
                          style: semiBoldTS.copyWith(
                              fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text(
                          disease['cause'] ?? 'No cause available',
                          style: regularTS.copyWith(
                              fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Prevention",
                          style: semiBoldTS.copyWith(
                              fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text(
                          disease['prevention'] ?? 'No prevention available',
                          style: regularTS.copyWith(
                              fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "How To Treat",
                          style: semiBoldTS.copyWith(
                              fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text(
                          disease['treatment'] ?? 'No treatment available',
                          style: regularTS.copyWith(
                              fontSize: 14, color: Colors.black),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Related Diseases",
                          style: semiBoldTS.copyWith(
                              fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 8),
                        Text(
                          disease['related_diseases'] ??
                              'No related diseases available',
                          style: regularTS.copyWith(
                              fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
