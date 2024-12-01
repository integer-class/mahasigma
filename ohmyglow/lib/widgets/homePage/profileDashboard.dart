import 'package:flutter/material.dart';
import '../../config/theme.dart';

class ProfileDashboard extends StatelessWidget {
  final String? username;

  const ProfileDashboard({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 30),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                "images/person.png",
                width: 45,
                height: 45,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi ${username}!",
                    style: boldTS.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text("Elevate your complextion care",
                      style: mediumItalicTS.copyWith(
                          fontSize: 11, color: Colors.black)),
                ],
              ),
            ),
            IconButton(
                alignment: Alignment.topRight,
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 35,
                )),
          ]),
        ],
      ),
    );
  }
}
