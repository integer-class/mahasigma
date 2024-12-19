import 'package:flutter/material.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support"),
        backgroundColor: Color(0xFFE9E0FC),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset("images/service.png"),
            Text("Help & Support Page"),
          ],
        ),
      ),
    );
  }
}
