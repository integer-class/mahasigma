import 'package:flutter/material.dart';

class MyError extends StatelessWidget {
  final String error;
  const MyError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
