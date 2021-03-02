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
    writeToFile(file_data);
  }

  void addInviteeToParty(Party party, Person person) {
    party.addInviteeToParty(invitee: person);
    List<dynamic> parties = file_data['parties'];

    parties.forEach((element) {
      if (element['id'] == party.id) {
        element['invitees'] = party.partyInvitees;
      }
    });

    file_data['parties'] = parties;
    writeToFile(file_data);
  }

  void deleteParty(String uuid) {}

  void removeInvitee(Party party, Person person) {
    party.partyInvitees.remove(person);
    List<dynamic> parties = file_data['parties'];
    parties.forEach((element) {
      if (element['id'] == party.id) {
        element['invitees'] = party.partyInvitees;
      }
    });
    file_data['parties'] = parties;
    writeToFile(file_data);
  }

  void addParty(Map<String, dynamic> json) async {
    Party newParty = Party.fromJson(json);

    file_data['parties'].add(json);

    writeToFile(file_data);
  }

  void writeToFile(dynamic file) {
    String jsonString = jsonEncode(file);
    try {
      filePath.writeAsString(jsonString);
    } catch (e) {
      print("Something went wrong $e");
    }
  }
}
