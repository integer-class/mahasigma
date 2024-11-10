import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.transparent,
        title: const Text("History Analysis"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          _HistoryCard(
            date: "1 September 2024",
            conditions: ["Oily", "Blackhead", "Acne"],
          ),
          _HistoryCard(
            date: "8 September 2024",
            conditions: ["Oily", "Blackhead", "Acne"],
          ),
          _HistoryCard(
            date: "22 September 2024",
            conditions: ["Oily", "Acne"],
          ),
          _HistoryCard(
            date: "29 September 2024",
            conditions: ["Oily"],
          ),
          _HistoryCard(
            date: "6 October 2024",
            conditions: ["Normal"],
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    super.key,
    required this.date,
    required this.conditions,
  });

  final String date;
  final List<String> conditions;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: conditions.map((condition) => Chip(
                label: Text(condition),
                backgroundColor: _getColorForCondition(condition),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color? _getColorForCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'oily':
        return Colors.green[100];
      case 'blackhead':
        return Colors.purple[100];
      case 'acne':
        return Colors.red.shade200;
      default:
        return Colors.blue.shade200;
    }
  }
}