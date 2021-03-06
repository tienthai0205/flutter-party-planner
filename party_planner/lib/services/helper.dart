import 'dart:convert';

import 'package:party_planner/models/party.dart';
import 'package:party_planner/models/person.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class Helper {
  Future modifyParty(Map<String, dynamic> updatedParty) async {
    List<dynamic> parties = file_data['parties'];
    parties.forEach((party) {
      if (party['id'] == updatedParty["id"]) {
        parties.remove(party);
        parties.add(updatedParty);
      }
    });
    writeToFile(file_data);
    // await sendEmail(
    //     updatedParty, 'Update ${updatedParty['name']} party detail!');
    return updatedParty;
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

  Future<List<dynamic>> removeInvitee(Party party, Person person) async {
    party.partyInvitees.remove(person);
    List<dynamic> parties = file_data['parties'];
    parties.forEach((element) {
      if (element['id'] == party.id) {
        element['invitees'] = party.partyInvitees;
      }
    });
    file_data['parties'] = parties;
    await writeToFile(file_data);
    return party.partyInvitees;
  }

  void addParty(Map<String, dynamic> json) async {
    Party newParty = Party.fromJson(json);

    file_data['parties'].add(json);

    writeToFile(file_data);
  }

  Future writeToFile(dynamic file) async {
    String jsonString = jsonEncode(file);
    try {
      filePath.writeAsStringSync(jsonString);
    } catch (e) {
      print("Something went wrong $e");
    }
  }

  Future<dynamic> sendEmail(Map<String, dynamic> party, String subject,
      {String email}) async {
    if (email == null) {
      party['invitees'].forEach((person) async {
        final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: person['email'],
            queryParameters: {'subject': subject});
        var url = emailLaunchUri.toString();
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not send invite';
        }
      });
    } else {
      final Uri emailLaunchUri = Uri(
          scheme: 'mailto', path: email, queryParameters: {'subject': subject});
      var url = emailLaunchUri.toString();
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not send invite';
      }
    }
  }
}
