import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:party_planner/models/party.dart';
import 'package:party_planner/screens/detail_screen/party_detail_screen.dart';
import 'package:party_planner/services/location.dart';

import '../../../constants.dart';

class PartyCard extends StatefulWidget {
  const PartyCard({
    Key key,
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.cardWidth,
    @required this.cardHeight,
    @required this.party,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final double cardWidth;
  final double cardHeight;
  final Party party;

  @override
  _PartyCardState createState() => _PartyCardState();
}

class _PartyCardState extends State<PartyCard> {
  String _currentAddress;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() {
    LocationHelper().getAddressFromLatLng(widget.party.location).then(
          (String data) => {
            this.setState(
              () {
                _currentAddress = data;
              },
            ),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new PartyDetailScreem(
                party: widget.party, locationString: _currentAddress),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: widget.screenHeight / 5,
        width: widget.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: kDarkGreen,
          boxShadow: [shadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PartyCardTopDetail(
              party: widget.party,
            ),
            PartyCardBottomDetail(
              cardWidth: widget.cardWidth,
              cardHeight: widget.cardHeight,
              party: widget.party,
              locationString: _currentAddress,
            ),
          ],
        ),
      ),
    );
  }
}

class PartyCardTopDetail extends StatelessWidget {
  const PartyCardTopDetail({Key key, this.party}) : super(key: key);

  final Party party;
  @override
  Widget build(BuildContext context) {
    int randomIconIndex = new Random().nextInt(3);
    String iconPath = iconList[randomIconIndex];

    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                party.name,
                style: kHeading.copyWith(fontSize: 15.0),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
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
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                party != null
                    ? '${party.numberOfInvitees} people are going'
                    : '0 people are going',
                style: kfontSecondary.copyWith(color: kLightTheme),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(iconPath),
            )
          ],
        ),
      ),
    );
  }
}

class PartyCardBottomDetail extends StatelessWidget {
  const PartyCardBottomDetail(
      {Key key,
      @required this.cardWidth,
      @required this.cardHeight,
      this.locationString,
      this.party})
      : super(key: key);

  final double cardWidth;
  final double cardHeight;
  final Party party;
  final String locationString;

  @override
  Widget build(BuildContext context) {
    DateTime partyTime = DateTime.parse(party.dateTime);

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
                  DateFormat.Hm().format(partyTime),
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
                  child: Text(locationString != null ? locationString : ""),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
