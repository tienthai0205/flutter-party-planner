import 'package:party_planner/models/person.dart';

class Party {
  int id;
  String name;
  String description;
  String dateTime;
  String location;
  bool invitationSent;
  List<Person> _partyInvitees;

  Party({
    this.id,
    this.name,
    this.description,
    this.dateTime,
    this.location,
    this.invitationSent,
  });

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        dateTime: json['dateTime'],
        location: json['location'],
        invitationSent: json['invitationSent']);
  }

  List<Person> partyInvitees() {
    return _partyInvitees;
  }

  void addInviteeToParty({Person invitee}) {
    _partyInvitees.add(invitee);
  }

  void removeInviteeFromParty({Person invitee}) {
    _partyInvitees.remove(invitee);
  }

  int get numberOfInvitees {
    return _partyInvitees.length;
  }
}
