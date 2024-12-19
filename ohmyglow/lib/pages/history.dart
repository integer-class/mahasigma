import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ohmyglow/utils/token_storage.dart';
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
    final token =
        await TokenStorage.getToken(); // Retrieve the token from storage
    if (token == null) {
      print("Token not found!");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url = Uri.parse('http://20.190.121.86/api/history');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Pass the token in the header
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _historyData = data['data']; // Ensure this matches your API response
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
        title: Text(
          "History Analysis",
          style: boldTS.copyWith(color: Colors.black),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _historyData.isEmpty
              ? Center(
                  child: Text(
                  'No history data available.',
                  style: TextStyle(fontSize: 16),
                ))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _historyData.length,
                  itemBuilder: (context, index) {
                    final history = _historyData[index];
                    return _HistoryCard(
                      date: history['created_at'],
                      conditions: List<String>.from(history['result']?? []),
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
