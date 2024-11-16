import 'package:flutter/material.dart';

class progressBar extends StatelessWidget {
  final String label;
  final double value;

  const progressBar({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        LinearProgressIndicator(
          value: value,
          minHeight: 8,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7BE285)),
        ),
        SizedBox(height: 10),
        Text(
          "${(value * 100).toStringAsFixed(1)}%", // Display percentage
          style: TextStyle(color: Colors.grey[700]),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
