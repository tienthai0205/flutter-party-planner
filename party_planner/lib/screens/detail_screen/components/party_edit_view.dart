import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:party_planner/models/person.dart';
import 'package:party_planner/services/helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import 'package:party_planner/models/party.dart';
import 'package:party_planner/screens/detail_screen/components/rounded_button.dart';

import '../../../constants.dart';
import 'invitee_list_view.dart';

class PartyEditView extends StatefulWidget {
  const PartyEditView({
    Key key,
    @required this.screenWidth,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;

  @override
  _PartyEditViewState createState() => _PartyEditViewState();
}

class _PartyEditViewState extends State<PartyEditView> {
  DateTime selectedDate;
  TimeOfDay selectedTime;
  final _formKey = GlobalKey<FormState>();
  String partyName;
  String description;
  Position location;
  Iterable<Contact> _contacts;
  Contact currentContact;

  @override
  Widget build(BuildContext context) {
    final Party party = ModalRoute.of(context).settings.arguments;

    return Container(
      height: widget.screenHeight * 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: widget.screenHeight * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    initialValue: party != null ? party.name : "",
                    style: kHeading2,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kLightTheme)),
                      helperText: 'Give your party an impressive name',
                      helperStyle: kHeading3.copyWith(fontSize: ktextsm),
                      labelText: 'Party name',
                      border: InputBorder.none,
                      labelStyle: kHeading3.copyWith(
                        color: kLightTheme.withOpacity(0.5),
                      ),
                    ),
                    onSaved: (name) => {partyName = name},
                  ),
                  TextFormField(
                    initialValue: party != null ? party.description : "",
                    style: kHeading2.copyWith(fontSize: ktextsm),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kLightTheme)),
                      helperText: 'Give your party an awesome description',
                      helperStyle: kHeading3.copyWith(fontSize: ktextsm),
                      border: InputBorder.none,
                      labelStyle: kHeading3.copyWith(
                        color: kLightTheme.withOpacity(0.5),
                      ),
                    ),
                    onSaved: (desc) => {description = desc},
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kYellowTheme,
                    ),
                    width: widget.screenWidth * 0.7,
                    child: TextFormField(
                      onTap: () {
                        getCurrentPosition();
                      },
                      style: kHeading2.copyWith(color: kDarkTheme),
                      decoration: InputDecoration(
                        hintText: location != null
                            ? "${location.latitude}, ${location.longitude}"
                            : "location",
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.location_on,
                          color: kDarkTheme,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: kLightTheme),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              _selectTime(context);
                            },
                            child: party != null
                                ? Text(
                                    DateFormat.Hm()
                                        .format(DateTime.parse(party.dateTime)),
                                    style: kHeading3,
                                  )
                                : Text(
                                    selectedTime != null
                                        ? "${selectedTime.format(context)}"
                                        : "Time",
                                    style: kHeading3,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: kLightTheme)),
                          child: FlatButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            child: party != null
                                ? Text(
                                    DateFormat.yMd()
                                        .format(DateTime.parse(party.dateTime)),
                                    style: kHeading3,
                                  )
                                : Text(
                                    selectedDate != null
                                        ? DateFormat.yMd().format(selectedDate)
                                        : "Date",
                                    style: kHeading3,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InviteesListView(
                    screenHeight: widget.screenHeight,
                    party: party != null ? party : null,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "new invitee",
                      hintStyle: TextStyle(color: kLightTheme.withOpacity(0.6)),
                      suffixIcon: IconButton(
                        onPressed: () => newInvite(party),
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: kLightPinkTheme,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedButton3Sides(
                        text: "Cancel",
                        onPress: () {
                          Navigator.pop(context);
                        },
                        side: 'bottom',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RoundedButton3Sides(
                        text: "Save",
                        onPress: () {
                          if (_formKey.currentState.validate() &&
                              party == null) {
                            createParty();
                            Navigator.pop(context);
                          } else if (_formKey.currentState.validate() &&
                              party != null) {
                            updateParty(party);
                          }
                        },
                        side: 'top',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createParty() {
    _formKey.currentState.save();
    var uuid = Uuid();
    print(DateFormat.yMd().format(selectedDate));
    DateTime dateTimeFormat = new DateTime(selectedDate.year, selectedDate.day,
        selectedDate.month, selectedTime.hour, selectedTime.minute);
    String isoFormat = dateTimeFormat.toIso8601String();
    print(isoFormat);
    Map<String, dynamic> party = {
      "id": uuid.v1(),
      "name": partyName,
      "description": description,
      "dateTime": isoFormat,
      "location": {
        "latitude": location.latitude,
        "longitude": location.longitude
      },
      "invitationSent": false,
      "imageLink": null,
      "invitees": []
    };
    Helper().addParty(party);
  }

  void updateParty(Party party) {
    _formKey.currentState.save();
    print(party.id);
    String isoFormat;
    // if (selectedDate != null && selectedTime == null) {
    //     DateTime dateTimeFormat = new DateTime(selectedDate.year, selectedDate.day, selectedDate.month);
    //     isoFormat = dateTimeFormat.toIso8601String();
    // } else if (selectedDate ==null && selectedTime != null){

    // } else if {

    // }

    // print(party.partyInvitees);
    print("Json encode ${json.encode(party.partyInvitees)}");
    List inviteesList =
        party.partyInvitees.map((invitee) => invitee.toJson()).toList();
    Map<String, dynamic> updatedParty = {
      "id": party.id,
      "name": partyName != null ? partyName : party.name,
      "description": description != null ? description : party.description,
      "dateTime": isoFormat != null ? isoFormat : party.dateTime,
      "location": {
        "latitude": party.location.latitude,
        "longitude": party.location.longitude
      },
      "invitationSent": party.invitationSent,
      "imageLink": party.imageLink,
      "invitees": inviteesList
    };
    Helper().modifyParty(updatedParty);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 0),
    );
    if (picked != null && picked != TimeOfDay(hour: 12, minute: 0))
      setState(() {
        selectedTime = picked;
      });
  }

  getCurrentPosition() {
    Geolocator.getCurrentPosition().then((value) => this.setState(() {
          location = new Position(
              latitude: value.latitude, longitude: value.longitude);
        }));
  }

  void newInvite(Party party) async {
    PermissionStatus permision = await _getPermission();
    if (permision == PermissionStatus.granted) {
      getContacts(party);
    } else {
      _getPermission();
    }
  }

  Future<void> getContacts(Party party) async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
      _openInviteBottomSheet(context, party);
    });
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  void _openInviteBottomSheet(context, party) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: ListView.builder(
            itemCount: _contacts?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              Contact contact = _contacts?.elementAt(index);
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(contact.avatar),
                      )
                    : CircleAvatar(
                        child: Text(contact.initials()),
                        backgroundColor: Theme.of(context).accentColor,
                      ),
                title: Text(contact.displayName ?? ''),
                trailing: IconButton(
                  icon: Icon(Icons.add_circle, color: kDarkTheme),
                  onPressed: () {
                    setState(() {
                      currentContact = contact;
                      _inviteDialog(party);
                    });
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  void addInviteeToList(Party party, BuildContext context) async {
    print(currentContact.displayName);
    String email = currentContact.emails.elementAt(0).value;
    String phone = currentContact.phones.elementAt(0).value;
    String emailSubject = "You are invited to ${party.name} party!";
    Helper().sendEmail(party.toJson(), emailSubject, email: email);

    Person newInvitee = new Person(
        name: currentContact.displayName, email: email, phoneNumber: phone);
    print("current party is ${party.name}");
    setState(() {
      Helper().addInviteeToParty(party, newInvitee);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }

  Future<void> _inviteDialog(Party party) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Send invite to ${currentContact.givenName}?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'This mean an email will be sent to ${currentContact.emails.first.value}'),
                Text('Would you like to proceed with the invitation?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Send'),
              onPressed: () {
                addInviteeToList(party, context);
              },
            ),
          ],
        );
      },
    );
  }
}
