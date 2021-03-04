import 'package:cool_alert/cool_alert.dart';
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

  var calendarsResult;
  @override
  void initState() {
    super.initState();
    _deviceCalendarPlugin = new DeviceCalendarPlugin();
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

  Future _addToCalendar() async {
    bool doesExist = false;
    calendarId = _calendars[0].id;
    Event eventToCreate = new Event(_calendars[0].id);
    eventToCreate.title = widget.party.name;
    eventToCreate.start = DateTime.parse(widget.party.dateTime);

    eventToCreate.description = widget.party.description;
    eventToCreate.end =
        DateTime.parse(widget.party.dateTime).add(new Duration(hours: 3));
    RetrieveEventsParams params = RetrieveEventsParams(
        startDate: DateTime.parse(widget.party.dateTime),
        endDate: eventToCreate.end);
    await _deviceCalendarPlugin
        .retrieveEvents(calendarId, params)
        .then((value) {
      if (value != null) {
        for (Event e in value.data) {
          if (e.title == eventToCreate.title) {
            print('change does exits, $value');
            doesExist = true;
          }
        }
        print('event ${value.data}');
      }
    });

    if (!doesExist) {
      final createEventResult =
          await _deviceCalendarPlugin.createOrUpdateEvent(eventToCreate);
      if (createEventResult.isSuccess &&
          (createEventResult.data?.isNotEmpty ?? false)) {
        return CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Event is successfully added to calendar!",
        );
      }
    } else {
      print('return');
      return CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Event already exists!",
      );
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
      if (calendarsResult != null) {
        _openCalendarBottomSheet();
      }
      setState(() {
        _calendars = calendarsResult?.data;
      });
    } catch (e) {
      print(e);
    }
  }

  void _openCalendarBottomSheet() {
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
                      _addToCalendar();
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
