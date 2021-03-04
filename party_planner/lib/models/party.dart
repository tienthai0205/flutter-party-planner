import 'package:geolocator/geolocator.dart';
import 'package:party_planner/models/person.dart';

class Party {
  String id;
  String name;
  String description;
  String dateTime;
  Position location;
  List<Person> partyInvitees = [];
  String imageLink;

  Party(
      {this.id,
      this.name,
      this.description,
      this.dateTime,
      this.location,
      this.imageLink,
      this.partyInvitees});

  factory Party.fromJson(Map<dynamic, dynamic> json) {
    return Party(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      dateTime: json['dateTime'],
      location: new Position(
          latitude: json['location']['latitude'],
          longitude: json['location']['longitude']),
      imageLink: json['imageLink'],
      partyInvitees: (json['invitees'] as List)
          .map(
            (data) => new Person.fromJson(data),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "dateTime": dateTime,
      "location": {
        "latitude": location.latitude,
        "longitude": location.longitude,
      },
      "imageLink": imageLink,
      "partyInvitees":
          partyInvitees.map((invitee) => invitee.toJson()).toList(),
    };
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

  bool get invitationSent {
    return partyInvitees.length > 0 ? true : false;
  }
}
