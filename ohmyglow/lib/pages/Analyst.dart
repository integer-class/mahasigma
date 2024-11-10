import 'package:flutter/material.dart';
import '../config/theme.dart';
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
          icon: ImageIcon(AssetImage('assets/Icons/arrow-left.png')),
        ),
        title: Text(
          "Graph Analysis",
          style: semiBoldTS.copyWith(fontSize: 16, color: Colors.black,),
          ),
      ),
    );
  }
}

