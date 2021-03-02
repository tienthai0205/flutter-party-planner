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
