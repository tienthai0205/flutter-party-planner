import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:party_planner/models/party.dart';

import '../../../constants.dart';

class PartyDetailTimeCard extends StatefulWidget {
  const PartyDetailTimeCard({Key key, this.time, this.date, this.party})
      : super(key: key);
  final Party party;
  final String time;
  final String date;

  @override
  _PartyDetailTimeCardState createState() => _PartyDetailTimeCardState();
}

class _PartyDetailTimeCardState extends State<PartyDetailTimeCard> {
  DeviceCalendarPlugin _deviceCalendarPlugin;
  String calendarId = '';
  List<Calendar> _calendars;
  Calendar _selectedCalendar;
  @override
  void initState() {
    super.initState();
    _deviceCalendarPlugin = new DeviceCalendarPlugin();
    _retrieveCalendars();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.watch_later,
                color: kLightTheme,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.time,
                  style: kfontSecondary.copyWith(color: kLightTheme),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => _retrieveCalendars(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: kLightTheme,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.date,
                    style: kfontSecondary.copyWith(color: kLightTheme),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future addToCalendar() async {
    print(_calendars[0].id);
    Event eventToCreate = new Event('6E9F1ED9-5335-477F-8EDF-FE38356FE204');
    eventToCreate.title = 'Random party';
    eventToCreate.start = DateTime.parse(widget.party.dateTime);

    eventToCreate.description = widget.party.description;
    eventToCreate.end =
        DateTime.parse(widget.party.dateTime).add(new Duration(hours: 3));
    final createEventResult =
        await _deviceCalendarPlugin.createOrUpdateEvent(eventToCreate);
    if (createEventResult.isSuccess &&
        (createEventResult.data?.isNotEmpty ?? false)) {
      print(createEventResult.data);
    }
  }

  void _retrieveCalendars() async {
    try {
      var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data) {
        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
          return;
        }
      }
      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      setState(() {
        _calendars = calendarsResult?.data;
      });
    } catch (e) {
      print(e);
    }
    _openInviteBottomSheet();
  }

  void _openInviteBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: ListView.builder(
            itemCount: _calendars?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                title: Text(_calendars[index].name),
                trailing: IconButton(
                  icon: Icon(Icons.add_circle, color: kDarkTheme),
                  onPressed: () {
                    setState(() {
                      print(_calendars[index].id);
                      Navigator.pop(context);
                      addToCalendar();
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
}
