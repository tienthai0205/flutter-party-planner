import 'package:party_planner/models/person.dart';

class Party {
  String name, description;
  DateTime dateTime;
  String location;
  bool invitationSent;
  List<Person> _partyInvitees;

  Party({
    this.description,
    this.dateTime,
    this.location,
    this.invitationSent,
  });

  // factory Party.fromJson(Map<String, dynamic> json) {
  //   return Party(
  //     date: json['date'],
  //     temperatureC: json['temperatureC'],
  //     temperatureF: json['temperatureF'],
  //     summary: json['summary'],
  //   );
  // }

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
