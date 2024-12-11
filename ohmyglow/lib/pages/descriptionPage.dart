import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/theme.dart';

class DescriptionPage extends StatelessWidget {
  final int diseaseId;

  const DescriptionPage({Key? key, required this.diseaseId}) : super(key: key);

  Future<Map<String, dynamic>> fetchDiseaseDetail() async {
    final response = await http.get(
      Uri.parse('http://your-api-url.com/api/diseases/$diseaseId'),
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: ImageIcon(AssetImage('assets/Icons/arrow-left.png')),
        ),
        title: Text(
          "Skin Problem",
          style: semiBoldTS.copyWith(fontSize: 16, color: Colors.black),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDiseaseDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final disease = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    disease['photo'] ?? '',
                    height: 200,
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
                ),
                SizedBox(height: 16),
                Text(
                  disease['name'] ?? 'Unknown Disease',
                  style: semiBoldTS.copyWith(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  disease['description'] ?? 'No description available',
                  style: regularTS.copyWith(fontSize: 14, color: Colors.black87),
                ),
                SizedBox(height: 16),
                Text(
                  "How To Treat",
                  style: semiBoldTS.copyWith(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 8),
                Column(
                  children: (disease['treatment'] as List<dynamic>?)
                          ?.map((step) => _buildTreatmentStep(step))
                          .toList() ??
                      [Text('No treatment steps available')],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTreatmentStep(String text) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: regularTS.copyWith(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}
