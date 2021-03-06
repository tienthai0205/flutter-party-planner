import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:party_planner/models/party.dart';
import 'package:party_planner/models/person.dart';
import 'package:party_planner/services/helper.dart';
import '../../../constants.dart';

class InviteesListView extends StatefulWidget {
  const InviteesListView({Key key, @required this.screenHeight, this.party})
      : super(key: key);

  final double screenHeight;
  final Party party;

  @override
  _InviteesListViewState createState() => _InviteesListViewState();
}

class _InviteesListViewState extends State<InviteesListView> {
  List<Person> invitees;
  @override
  void initState() {
    super.initState();
    this.invitees = widget.party != null ? widget.party.partyInvitees : [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Invitees",
          style: kHeading.copyWith(
            fontSize: 20,
          ),
        ),
        Container(
            height: widget.party != null && widget.party.invitationSent
                ? widget.screenHeight / 6
                : 10.0,
            child: widget.party != null
                ? ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (_, index) => ListTile(
                      title: Text(invitees[index].name),
                      leading:
                          SvgPicture.asset("assets/icons/profile_icon.svg"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Color(0xffE84A5F),
                        ),
                        onPressed: () {
                          Helper()
                              .removeInvitee(widget.party, invitees[index])
                              .then((value) => this.setState(() {
                                    widget.party.partyInvitees = value;
                                  }));
                        },
                      ),
                    ),
                    itemCount: invitees.length,
                  )
                : Container()),
      ],
    );
  }
}
