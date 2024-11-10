import 'package:flutter/material.dart';

class AnalystPage extends StatelessWidget {
  const AnalystPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Graph Analysis"),
      ),
    );
  }
}

