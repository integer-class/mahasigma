import 'package:flutter/material.dart';
import '../../config/theme.dart';

Widget profileDashboard = Padding(
  padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(children: [
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
                "Hi Awaa!",
                style: boldTS.copyWith(fontSize: 16, color: Colors.black,),
              ),
              Text(
                "Elevate your complextion care",
                style: mediumItalicTS.copyWith(fontSize: 13, color: Colors.black)
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
            alignment: Alignment.topRight,
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              size: 35,
            )),
      ]),
      // const Padding(
      //   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      //   child: Row(
      //     children: [
      //       Text(
      //         "30°",
      //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
      //         child: Icon(
      //           Icons.sunny,
      //           color: Colors.yellow,
      //         ),
      //       ),
      //       Text(
      //         "Sunny | Humadity: 70% | UV: 8",
      //         style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      //       ),
      //       // Padding(
      //       //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      //       //     child: Text("|",
      //       //         style: TextStyle(
      //       //             fontSize: 15, fontWeight: FontWeight.bold))),
      //       // Text(
      //       //   "Humidity: 70%",
      //       //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      //       // ),
      //       // Padding(
      //       //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      //       //     child: Text("|",
      //       //         style: TextStyle(
      //       //             fontSize: 15, fontWeight: FontWeight.bold))),
      //       // Text(
      //       //   "UV: 8",
      //       //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      //       // ),
      //     ],
      //   ),
      // ),
      // const Padding(
      //   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      //   child: Text(
      //     "High temperatures today, don't forget to use sunscreen!",
      //     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      //   ),
      // ),
    ],
  ),
);
