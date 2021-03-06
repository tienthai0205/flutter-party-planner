import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:party_planner/models/party.dart';
import 'package:party_planner/screens/detail_screen/components/party_time_card.dart';
import 'package:party_planner/services/permission.dart';
import 'package:party_planner/widgets/rounded_button.dart';
import '../../../constants.dart';
import 'invitee_list_view.dart';

class PartyDetailView extends StatelessWidget {
  const PartyDetailView(
      {Key key,
      @required this.screenWidth,
      @required this.screenHeight,
      this.locationString,
      @required this.party})
      : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final Party party;
  final String locationString;

  @override
  Widget build(BuildContext context) {
    DateTime partyDateTime;
    if (party != null) {
      partyDateTime = DateTime.parse(party.dateTime);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                party.name,
                style: kHeading.copyWith(fontSize: 20),
              ),
              IconButton(
                icon: party.invitationSent
                    ? Icon(
                        Icons.check_circle_outline,
                        color: kPositive,
                      )
                    : SvgPicture.asset(
                        "assets/icons/send_invite_icon.svg",
                        color: kYellowTheme,
                      ),
                onPressed: () {},
              ),
            ],
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: kYellowTheme,
              ),
              width: screenWidth * 0.7,
              child: ListTile(
                onTap: () => PermissionHelper().determinePosition(),
                title: Text(
                  locationString,
                  style: kfontSecondary.copyWith(
                      fontWeight: FontWeight.w700, fontSize: ktextsm2),
                ),
                leading: Icon(
                  Icons.location_on,
                  color: kDarkTheme,
                ),
              )),
          PartyDetailTimeCard(
              time: DateFormat.Hm().format(partyDateTime),
              date: DateFormat.yMd().format(partyDateTime),
              party: party),
          Container(
            child: Text(
              party != null ? party.description : '',
              style: kfontSecondary.copyWith(color: kLightTheme),
            ),
          ),
          InviteesListView(
            screenHeight: screenHeight,
            party: party,
          ),
          Row(
            children: [
              RoundedButton3Sides(
                text: "Edit",
                onPress: () {
                  Navigator.pushNamed(context, 'new_party', arguments: party);
                },
                side: 'top',
              ),
            ],
          )
        ],
      ),
    );
  }
}
