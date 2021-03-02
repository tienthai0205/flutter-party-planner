import 'dart:convert';

import 'package:party_planner/models/party.dart';

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

  void deleteParty(String uuid) {}

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
