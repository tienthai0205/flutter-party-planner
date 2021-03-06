import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:party_planner/models/party.dart';
import 'package:party_planner/screens/detail_screen/components/party_time_card.dart';
import 'package:party_planner/services/permission.dart';
import 'package:party_planner/widgets/rounded_button.dart';
import '../../../constants.dart';
import 'invitee_list_view.dart';

class PartyDetailView extends StatefulWidget {
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
  _PartyDetailViewState createState() => _PartyDetailViewState();
}

class _PartyDetailViewState extends State<PartyDetailView> {
  Party updatedParty;
  FutureOr onGoBack(dynamic value) {
    setState(() {
      updatedParty = Party.fromJson(value);
      print(value);
      widget.party.name = updatedParty.name;
      widget.party.dateTime = updatedParty.dateTime;
      widget.party.description = updatedParty.description;
      widget.party.location = updatedParty.location;
      widget.party.partyInvitees = updatedParty.partyInvitees;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime partyDateTime;
    if (widget.party != null) {
      partyDateTime = DateTime.parse(widget.party.dateTime);
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
              Expanded(
                child: Text(
                  widget.party.name,
                  style: kHeading.copyWith(fontSize: 20),
                ),
              ),
              IconButton(
                icon: widget.party.invitationSent
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
              width: widget.screenWidth * 0.7,
              child: ListTile(
                onTap: () => PermissionHelper().determinePosition(),
                title: Text(
                  widget.locationString,
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
              party: widget.party),
          Container(
            child: Text(
              widget.party != null ? widget.party.description : '',
              style: kfontSecondary.copyWith(color: kLightTheme),
            ),
          ),
          InviteesListView(
            screenHeight: widget.screenHeight,
            party: updatedParty == null ? widget.party : updatedParty,
          ),
          Row(
            children: [
              RoundedButton3Sides(
                text: "Edit",
                onPress: () {
                  Navigator.pushNamed(context, 'new_party',
                          arguments: widget.party)
                      .then((onGoBack));
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
