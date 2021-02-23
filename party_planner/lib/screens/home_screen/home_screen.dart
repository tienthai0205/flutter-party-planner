import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:party_planner/constants.dart';
import 'package:party_planner/models/party.dart';
import 'package:http/http.dart' as http;

import 'components/party_card.dart';
import 'components/timeline_title.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Party> parties;

  @override
  void initState() {
    super.initState();
    parties = new List<Party>();
    _fetchParties();
  }

  void _fetchParties() async {
    const url =
        "https://my-json-server.typicode.com/tienthai460592/faker/parties";
    final response = await http.get(url);
    parties = (jsonDecode(response.body) as List)
        .map((data) => new Party.fromJson(data))
        .toList();
    setState(() {
      this.parties = parties;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double cardWidth = screenWidth - 40.0;
    double cardHeight = screenHeight / 11;

    return Scaffold(
      backgroundColor: kDarkTheme,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.red),
              ),
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hi Gerralt!",
                style: kHeading,
              ),
              Container(
                height: screenHeight * 0.75,
                child: ListView.separated(
                  itemBuilder: (_, index) => PartyCard(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    cardWidth: cardWidth,
                    cardHeight: cardHeight,
                    party: parties[index],
                  ),
                  separatorBuilder: (context, index) => TimelineTitle(
                    screenWidth: screenWidth,
                    text: "Friday, 12 March",
                  ),
                  itemCount: parties.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
