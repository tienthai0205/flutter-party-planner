import 'package:flutter/material.dart';
import 'package:party_planner/constants.dart';
import 'package:party_planner/models/party.dart';
import 'package:party_planner/screens/detail_screen/components/party_edit_view.dart';

import 'components/hero_image.dart';
import 'components/party_detail_view.dart';

class PartyDetailScreem extends StatelessWidget {
  PartyDetailScreem({this.party, this.locationString});
  final Party party;
  final String locationString;
  @override
  Widget build(BuildContext context) {
    // final Party party = ModalRoute.of(context).settings.arguments;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PartyHeroImage(
              screenHeight: screenHeight,
              imageLink: party != null ? party.imageLink : null),
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
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                party: party != null ? party : null),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight * 0.7),
                child: party != null
                    ? PartyDetailView(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        party: party,
                        locationString: locationString)
                    : PartyEditView(
                        screenWidth: screenWidth, screenHeight: screenHeight),
              ),
            ),
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
    @required this.party,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final Party party;

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
    );
  }
}
