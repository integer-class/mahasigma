import 'package:flutter/material.dart';
import '../../config/theme.dart';

class Cardmenu extends StatelessWidget {
  final String image;
  final String title;

  const Cardmenu({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 4,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: const Color(0xFFDDF7DF),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.height * 0.11,
                height: MediaQuery.of(context).size.height * 0.11,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title,
                style: regularTS.copyWith(
                  fontSize: 13,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
