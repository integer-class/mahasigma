import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/theme.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> _historyData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    final url = Uri.parse('http://20.190.121.86/api/history');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _historyData = data['data'];
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
    return Scaffold(
      appBar: AppBar(
        title: Text("History Analysis"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _historyData.length,
              itemBuilder: (context, index) {
                final history = _historyData[index];
                return _HistoryCard(
                  date: history['date'],
                  conditions: List<String>.from(history['conditions']),
                );
              },
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: conditions
                  .map((condition) => Chip(
                        label: Text(
                          condition,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: _getColorForCondition(condition),
                      ))
                  .toList(),
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

