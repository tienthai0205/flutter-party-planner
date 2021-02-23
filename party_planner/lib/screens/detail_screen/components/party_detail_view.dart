import 'package:flutter/material.dart';
import 'package:party_planner/screens/detail_screen/components/party_time_card.dart';
import 'package:party_planner/screens/detail_screen/components/rounded_button.dart';

import '../../../constants.dart';
import 'invitee_list_view.dart';

class PartyDetailView extends StatelessWidget {
  const PartyDetailView({
    Key key,
    @required this.screenWidth,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Champagne Lux Sips",
            style: kHeading.copyWith(fontSize: 20),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: kYellowTheme,
            ),
            width: screenWidth * 0.7,
            child: ListTile(
              title: Text(
                "3 Beverly Hills,  LA",
                style: kfontSecondary.copyWith(
                    fontWeight: FontWeight.w700, fontSize: ktextsm2),
              ),
              leading: Icon(
                Icons.location_on,
                color: kDarkTheme,
              ),
            ),
          ),
          PartyDetailTimeCard(),
          Container(
            child: Text(
              "Join this amazing party where we have awesome music with special guests none other than: Mike Music, Sandra Song, Billy Boombox and Cara Caraoke!",
              style: kfontSecondary.copyWith(color: kLightTheme),
            ),
          ),
          InviteesListView(screenHeight: screenHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButton3Sides(
                text: "Cancle",
                onPress: () {},
              ),
              SizedBox(
                width: 10,
              ),
              RoundedButton3Sides(
                text: "Save",
                onPress: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
