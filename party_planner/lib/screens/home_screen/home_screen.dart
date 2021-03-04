import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:party_planner/constants.dart';
import 'package:party_planner/models/party.dart';
import 'package:party_planner/models/person.dart';

import 'components/party_card.dart';
import 'components/timeline_title.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Party> parties;
  List<Person> persons;
  bool _loading = true;
  String _jsonString;

  @override
  void initState() {
    super.initState();
    parties = new List<Party>();
    needInit();
    // initFile();  //first time install
    // _fetchData();
  }

  void needInit() async {
    filePath = await localFile;
    String result = await filePath.readAsString();
    if (result == null) {
      initFile();
      _fetchData();
    } else {
      _fetchData();
    }
  }

  // void _fetchParties() async {
  //   const url =
  //       "https://my-json-server.typicode.com/tienthai460592/faker/parties";
  //   final response = await http.get(url);
  //   parties = (jsonDecode(response.body) as List)
  //       .map((data) => new Party.fromJson(data))
  //       .toList();
  //   setState(() {
  //     this.parties = parties;
  //     _loading = false;
  //   });
  // }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      _fetchData();
    });
  }

  void _fetchData() async {
    filePath = await localFile;
    print(filePath);
    try {
      _jsonString = await filePath.readAsString();

      file_data = jsonDecode(_jsonString);
      parties = (file_data['parties'] as List)
          .map((data) => new Party.fromJson(data))
          .toList();
      setState(() {
        this.parties = parties;
        _loading = false;
      });
    } catch (e) {
      print('Tried reading _file error: $e');
    }
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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hi Gerralt!",
                    style: kHeading,
                  ),
                  Container(
                    height: screenHeight * 0.75,
                    child: _loading
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(kLightTheme),
                            ),
                          )
                        : GroupedListView(
                            elements: parties,
                            groupBy: (Party party) =>
                                groupEventByDate(timeStamp: party.dateTime),
                            itemBuilder: (_, element) => PartyCard(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              cardWidth: cardWidth,
                              cardHeight: cardHeight,
                              party: element,
                            ),
                            groupComparator: (gr1, gr2) =>
                                groupEventsOrder(gr1, gr2),
                            groupSeparatorBuilder: (value) => TimelineTitle(
                              screenWidth: screenWidth,
                              text: value,
                            ),
                          ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: kLightPinkTheme,
                    shape: BoxShape.circle,
                    boxShadow: [shadow],
                  ),
                  width: screenWidth * 0.18,
                  height: screenWidth * 0.18,
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: screenWidth * 0.15,
                    ),
                    color: kDarkTheme,
                    onPressed: () {
                      Navigator.pushNamed(context, 'new_party').then(onGoBack);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String groupEventByDate({String timeStamp}) {
    String dateSlug;
    DateTime partyTimeStamp = DateTime.parse(timeStamp);

    dateSlug = DateFormat.yMMMMEEEEd().format(partyTimeStamp);
    return dateSlug;
  }

  int groupEventsOrder(String gr1, String gr2) {
    final formatter = DateFormat(r'EEEE, MMMM dd, yyyy');

    DateTime gr1Time = formatter.parse(gr1);
    DateTime gr2Time = formatter.parse(gr2);
    return gr1Time.compareTo(gr2Time);
  }
}
