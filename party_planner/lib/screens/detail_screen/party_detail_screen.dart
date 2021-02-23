import 'package:flutter/material.dart';
import 'package:party_planner/constants.dart';

import 'components/hero_image.dart';
import 'components/party_detail_view.dart';

class PartyDetailScreem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PartyHeroImage(screenHeight: screenHeight),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: kLightTheme,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PartyDetailWrapper(
                screenHeight: screenHeight, screenWidth: screenWidth),
          ),
        ],
      ),
    );
  }
}

class PartyDetailWrapper extends StatelessWidget {
  const PartyDetailWrapper({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              color: Color(0xff1F1F1F),
              offset: Offset(0, 0),
            ),
          ],
          color: kDarkTheme),
      height: screenHeight * 0.7,
      width: screenWidth,
      child:
          PartyDetailView(screenWidth: screenWidth, screenHeight: screenHeight),
    );
  }
}
