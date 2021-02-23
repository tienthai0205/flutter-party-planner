import 'package:party_planner/models/party.dart';

class Person {
  String name;
  String email;
  String phoneNumber;

  Person({
    this.name,
    this.email,
    this.phoneNumber,
  });

  // factory Party.fromJson(Map<String, dynamic> json) {
  //   return Party(
  //     date: json['date'],
  //     temperatureC: json['temperatureC'],
  //     temperatureF: json['temperatureF'],
  //     summary: json['summary'],
  //   );
  // }

  List<Party> get listOfParties {
    return null;
  }
}
