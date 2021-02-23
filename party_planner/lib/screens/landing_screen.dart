import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:party_planner/widgets/rounded_border_btn.dart';

import '../constants.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kLightPinkTheme,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: screenWidth / 2.2,
            bottom: screenHeight / 1.35,
            child: SvgPicture.asset(
              'assets/icons/organge_pattern.svg',
              height: screenHeight / 3,
            ),
          ),
          Positioned(
            left: screenWidth / 1.25,
            bottom: screenHeight / 1.55,
            child: SvgPicture.asset(
              'assets/icons/grey_pattern.svg',
            ),
          ),
          Positioned(
            left: screenWidth / 1.6,
            bottom: screenHeight / 3,
            child: SvgPicture.asset(
              'assets/icons/red_pattern.svg',
              height: screenHeight / 3,
            ),
          ),
          Positioned(
            top: screenHeight / 1.8,
            left: -screenWidth / 2.7,
            child: SvgPicture.asset(
              'assets/icons/orange_oval_pattern.svg',
              height: screenHeight / 1.4,
            ),
          ),
          Positioned(
            top: screenHeight / 2.8,
            left: -screenWidth / 3,
            child: SvgPicture.asset(
              'assets/icons/dark_green_pattern.svg',
              height: screenHeight / 4,
            ),
          ),
          Positioned(
            top: -30,
            left: 20,
            child: SvgPicture.asset(
              'assets/icons/string_pattern.svg',
              width: screenWidth,
            ),
          ),
          Positioned(
            top: screenHeight / 5,
            left: screenWidth / 7,
            child: Text(
              'Party \nPlanner',
              style: TextStyle(
                fontFamily: 'Industry',
                fontSize: screenWidth / 10,
                height: 1.7,
              ),
            ),
          ),
          Positioned(
            top: screenHeight / 1.17,
            child: RoundedBorderButton(
              text: Text(
                "Let's get the party started!",
                style: TextStyle(color: kLightTheme),
              ),
              onPressFunction: () => {
                Navigator.pushNamed(context, 'home_screen'),
              },
              width: screenWidth / 2,
              height: screenHeight / 15,
            ),
          ),
        ],
      ),
    );
  }
}
