import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:party_planner/models/party.dart';
import 'package:party_planner/screens/detail_screen/components/party_time_card.dart';
import 'package:party_planner/screens/detail_screen/components/rounded_button.dart';

import '../../../constants.dart';
import 'invitee_list_view.dart';

class PartyDetailView extends StatelessWidget {
  const PartyDetailView({
    Key key,
    @required this.screenWidth,
    @required this.screenHeight,
    @required this.party,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final Party party;

  @override
  Widget build(BuildContext context) {
    DateTime partyDateTime = DateTime.parse(party.dateTime);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            party.name,
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
                party.location,
                style: kfontSecondary.copyWith(
                    fontWeight: FontWeight.w700, fontSize: ktextsm2),
              ),
              leading: Icon(
                Icons.location_on,
                color: kDarkTheme,
              ),
            ),
          ),
          PartyDetailTimeCard(
              time: DateFormat.Hm().format(partyDateTime),
              date: DateFormat.yMd().format(partyDateTime)),
          Container(
            child: Text(
              party.description,
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
                side: 'bottom',
              ),
              SizedBox(
                width: 10,
              ),
              RoundedButton3Sides(
                text: "Save",
                onPress: () {},
                side: 'top',
              ),
            ],
          )
        ],
      ),
    );
  }
}
