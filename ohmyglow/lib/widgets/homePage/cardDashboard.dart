import 'package:flutter/material.dart';

Widget cardDashboard = Card(
  elevation: 4,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
  color: const Color(0xFFE9E0FC),
  child: Padding(
    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              "images/person.png",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Awaa",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                size: 50,
              )),
        ]),
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            children: [
              Text(
                "30°",
                style: TextStyle(fontSize: 30),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: Icon(
                  Icons.sunny,
                  color: Colors.yellow,
                ),
              ),
              Text(
                "Sunny",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text("|",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
              Text(
                "Humidity: 70%",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text("|",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold))),
              Text(
                "UV: 8",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            "High temperatures today, don't forget to use sunscreen!",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  ),
);
