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

  factory Person.fromJson(Map<dynamic, dynamic> json) {
    return Person(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  List<Party> get listOfParties {
    return null;
  }
}
