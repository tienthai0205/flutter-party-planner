import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kDarkTheme = Color(0xff292529);
const Color kYellowTheme = Color(0xffE4BC91);
const Color kLightTheme = Color(0xffE5DED9);
const Color kLightPinkTheme = Color(0xffFECEA8);
const Color kDarkGreen = Color(0xff2A292D);
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
BoxShadow shadow = BoxShadow(
  color: Color(0xff1D1D1D),
  blurRadius: 5,
  offset: Offset(0, 3), // changes position of shadow
);
