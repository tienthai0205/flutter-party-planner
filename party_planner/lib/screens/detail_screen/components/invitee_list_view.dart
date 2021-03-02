import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:party_planner/models/party.dart';
import 'package:party_planner/models/person.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../constants.dart';
import 'package:contacts_service/contacts_service.dart';

class InviteesListView extends StatefulWidget {
  const InviteesListView({Key key, @required this.screenHeight, this.party})
      : super(key: key);

  final double screenHeight;
  final Party party;

  @override
  _InviteesListViewState createState() => _InviteesListViewState();
}

class _InviteesListViewState extends State<InviteesListView> {
  Iterable<Contact> _contacts;
  Contact currentContact;

  List<Person> invitees;
  @override
  void initState() {
    super.initState();
    this.invitees = widget.party != null ? widget.party.partyInvitees : [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Invitees",
          style: kHeading.copyWith(
            fontSize: 20,
          ),
        ),
        Container(
          height: widget.party != null ? widget.screenHeight / 6 : 10.0,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemBuilder: (_, index) => ListTile(
              title: Text(invitees[index].name),
              leading: SvgPicture.asset("assets/icons/profile_icon.svg"),
              trailing: Icon(
                Icons.cancel_outlined,
                color: Color(0xffE84A5F),
              ),
            ),
            itemCount: widget.party != null ? invitees.length : 0,
          ),
        ),
        Container(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "new invitee",
              hintStyle: TextStyle(color: kLightTheme.withOpacity(0.6)),
              suffixIcon: IconButton(
                onPressed: () => newInvite(),
                icon: Icon(
                  Icons.add_circle_outline,
                  color: kLightPinkTheme,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void newInvite() async {
    PermissionStatus permision = await _getPermission();
    if (permision == PermissionStatus.granted) {
      getContacts();
    } else {
      _getPermission();
    }
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
      _openInviteBottomSheet(context);
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

  void _openInviteBottomSheet(context) {
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
                      addInviteeToList();
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

  void addInviteeToList() {
    String email = currentContact.emails.elementAt(0).value;
    String phone = currentContact.phones.elementAt(0).value;
    print(email);
    Person newInvitee = new Person(
        name: currentContact.displayName, email: email, phoneNumber: phone);
    widget.party.addInviteeToParty(invitee: newInvitee);
  }
}
