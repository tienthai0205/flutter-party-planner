import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class PartyCard extends StatelessWidget {
  const PartyCard({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.cardWidth,
    @required this.cardHeight,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final double cardWidth;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: screenHeight / 5,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: kDarkGreen,
        boxShadow: [shadow],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PartyCardTopDetail(),
          PartyCardBottomDetail(cardWidth: cardWidth, cardHeight: cardHeight)
        ],
      ),
    );
  }
}

class PartyCardTopDetail extends StatelessWidget {
  const PartyCardTopDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "The RnB Party",
                style: kHeading.copyWith(fontSize: 15.0),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "10 people are going",
                style: kfontSecondary.copyWith(color: kLightTheme),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset("assets/icons/baloon_icon.svg"),
            )
          ],
        ),
      ),
    );
  }
}

class PartyCardBottomDetail extends StatelessWidget {
  const PartyCardBottomDetail({
    Key key,
    @required this.cardWidth,
    @required this.cardHeight,
  }) : super(key: key);

  final double cardWidth;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: kYellowTheme,
            borderRadius: BorderRadius.circular(10),
          ),
          width: cardWidth / 2,
          height: cardHeight,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.watch_later,
                  color: kDarkGreen,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "21:00",
                  style: kfontSecondary.copyWith(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        DottedLine(
          direction: Axis.vertical,
          lineLength: cardHeight / 1.5,
          dashColor: kYellowTheme,
          dashGapLength: 6,
          lineThickness: 1,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: kYellowTheme,
              borderRadius: BorderRadius.circular(10),
            ),
            height: cardHeight,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.location_on,
                    color: kDarkGreen,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "3 Beverly Hills, LA",
                    style: kfontSecondary.copyWith(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
