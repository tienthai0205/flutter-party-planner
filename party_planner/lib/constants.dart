import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kDarkTheme = Color(0xff292529);
const Color kYellowTheme = Color(0xffE4BC91);
const Color kLightTheme = Color(0xffE5DED9);
const Color kLightPinkTheme = Color(0xffFECEA8);
const Color kDarkGreen = Color(0xff2A292D);
const Color kPositive = Color(0xff00917c);
const double ktextsm = 12;
const double ktextsm2 = 16;
const double ktextmd = 18;
const double ktextlg = 22;
const double ktext2xlg = 25;
const FontWeight kfontlight = FontWeight.w200;
const FontWeight kfontmd = FontWeight.w500;
TextStyle kHeading = TextStyle(
    fontFamily: 'Galvji',
    fontWeight: FontWeight.w700,
    color: kLightTheme,
    fontSize: ktextlg);
TextStyle kHeading2 = GoogleFonts.nunito(color: kLightTheme, fontSize: ktextmd);
TextStyle kHeading3 =
    GoogleFonts.nunito(color: kLightTheme, fontSize: ktextsm2);
TextStyle kfont = TextStyle(fontFamily: 'Galvji');
TextStyle kfontSecondary = GoogleFonts.nunito();
const BoxShadow shadow = BoxShadow(
  color: Color(0xff1D1D1D),
  blurRadius: 5,
  offset: Offset(0, 3), // changes position of shadow
);
const url = "https://my-json-server.typicode.com/tienthai460592/faker/parties";
const iconList = [
  "assets/icons/baloon_icon.svg",
  "assets/icons/champagne_icon.svg",
  "assets/icons/dancing_icon.svg"
];
const String imagePlaceholder =
    "https://images.unsplash.com/photo-1486556396467-d83d2b23514b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80";
File filePath;
Map<String, dynamic> file_data = {};

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get localFile async {
  final path = await _localPath;
  return File('$path/data');
}

void initFile() async {
  final file = await localFile;
  Map<String, dynamic> data = {
    "parties": [
      {
        "id": "1",
        "name": "The RnB Party",
        "description":
            "Every 4 months the Festival of Dogs is celebrated with much gratification. It's a holiday with fairly modern roots, but today it is mostly associated with bonding with friends, watching special shows, lighting candles and fireworks.",
        "dateTime": "2021-03-15T21:00:49+0100",
        "location": {"longitude": -83.64, "latitude": 32.79},
        "imageLink":
            "https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2700&q=80",
        "invitees": [
          {
            "name": "Ruud",
            "email": "ruud@email.com",
            "phoneNumber": "0123456789"
          }
        ]
      },
      {
        "id": "20182f80-7b78-11eb-a1c7-d336e3479a80",
        "name": "wfwfwf",
        "description": "wfwfwfwfwf",
        "dateTime": "2023-01-03T20:00:00.000",
        "location": {"latitude": 37.785834, "longitude": -122.406417},
        "invitationSent": false,
        "imageLink": null,
        "invitees": []
      },
      {
        "id": "39d51550-7b78-11eb-ad33-25d62e916e6e",
        "name": "rrheh",
        "description": "rhreheher",
        "dateTime": "2022-12-03T17:50:00.000",
        "location": {"latitude": 37.785834, "longitude": -122.406417},
        "invitationSent": false,
        "imageLink": null,
        "invitees": []
      },
      {
        "id": "ce6a9060-7b81-11eb-bae9-27ffd78fc0a7",
        "name": "wfwqweeee",
        "description": "ewgewgewbewbeb",
        "dateTime": "2021-10-03T08:00:00.000",
        "location": {"latitude": 37.785834, "longitude": -122.406417},
        "invitationSent": false,
        "imageLink": null,
        "invitees": []
      },
      {
        "id": "2",
        "name": "Champagne Lux Sips",
        "description":
            "Join this amazing party where we have awesome music with special guests none other than: Mike Music, Sandra Song, Billy Boombox and Cara Caraoke!",
        "dateTime": "2021-03-15T21:00:49+0100",
        "location": {"latitude": 32.79, "longitude": -83.64},
        "invitationSent": true,
        "imageLink":
            "https://images.unsplash.com/photo-1517457373958-b7bdd4587205?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80",
        "invitees": [
          {
            "name": "Ruud",
            "email": "ruud@email.com",
            "phoneNumber": "0123456789"
          }
        ]
      },
      {
        "id": "3",
        "name": "Night Craving",
        "description":
            "The skyline is packed with unique skyscrapers and a new one seems to pop up every other week. The quality of life is high in Freyford and it has attracted a lot of attention. ",
        "dateTime": "2021-03-17T22:00:49+0100",
        "location": {"latitude": 32.79, "longitude": -83.64},
        "invitationSent": true,
        "imageLink":
            "https://images.unsplash.com/photo-1492684223066-81342ee5ff30?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1650&q=80",
        "invitees": [
          {
            "name": "Ruud",
            "email": "ruud@email.com",
            "phoneNumber": "0123456789"
          },
          {
            "name": "Anna Haro",
            "email": "anna-haro@mac.com",
            "phoneNumber": "555-522-8243"
          },
          {
            "name": "John Appleseed",
            "email": "John-Appleseed@mac.com",
            "phoneNumber": "888-555-5512"
          }
        ]
      }
    ]
  };
  String json = jsonEncode(data);

  try {
    file.writeAsString(json);
  } catch (e) {
    print("Something went wrong $e");
  }
}
