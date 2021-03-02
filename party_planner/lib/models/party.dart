import 'package:party_planner/models/person.dart';

class Party {
  String id;
  String name;
  String description;
  String dateTime;
  String location;
  bool invitationSent;
  List<Person> partyInvitees = [];
  String imageLink;

  Party(
      {this.id,
      this.name,
      this.description,
      this.dateTime,
      this.location,
      this.invitationSent,
      this.imageLink,
      this.partyInvitees});

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      dateTime: json['dateTime'],
      location: json['location'],
      invitationSent: json['invitationSent'],
      imageLink: json['imageLink'],
      partyInvitees: (json['invitees'] as List)
          .map(
            (data) => new Person.fromJson(data),
          )
          .toList(),
    );
  }

  void addInviteeToParty({Person invitee}) {
    partyInvitees.add(invitee);
  }

  void removeInviteeFromParty({Person invitee}) {
    partyInvitees.remove(invitee);
  }

  int get numberOfInvitees {
    return partyInvitees != null ? partyInvitees.length : 0;
  }
}
