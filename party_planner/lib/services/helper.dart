import 'dart:convert';

import 'package:party_planner/models/party.dart';
import 'package:party_planner/models/person.dart';

import '../constants.dart';

class Helper {
  void modifyParty(Map<String, dynamic> updatedParty) {
    List<dynamic> parties = file_data['parties'];
    parties.forEach((party) {
      if (party['id'] == updatedParty["id"]) {
        parties.remove(party);
        parties.add(updatedParty);
      }
    });
    String jsonString = jsonEncode(file_data);
    try {
      filePath.writeAsString(jsonString);
      // Navigator.pop(context);
    } catch (e) {
      print("Something went wrong $e");
    }
  }

  void addInviteeToParty(Party party, Person person) {
    party.addInviteeToParty(invitee: person);
    List<dynamic> parties = file_data['parties'];

    parties.forEach((element) {
      if (element['id'] == party.id) {
        element['invitees'] = party.partyInvitees;
      }
    });
    print("Parties $parties");
    file_data['parties'] = parties;

    String jsonString = jsonEncode(file_data);
    try {
      filePath.writeAsString(jsonString);
    } catch (e) {
      print("Something went wrong $e");
    }
  }

  void deleteParty(String uuid) {}

  void removeInvitee(Party party, Person person) {
    party.partyInvitees.remove(person);
    List<dynamic> parties = file_data['parties'];
    Map<String, dynamic> updatedParty;
    parties.forEach((element) {
      if (element['id'] == party.id) {
        element['invitees'] = party.partyInvitees;
      }
    });
  }

  void addParty(Map<String, dynamic> json) async {
    String jsonString;

    Party newParty = Party.fromJson(json);

    file_data['parties'].add(json);

    jsonString = jsonEncode(file_data);
    try {
      filePath.writeAsString(jsonString);
      // Navigator.pop(context);
    } catch (e) {
      print("Something went wrong $e");
    }
  }
}
