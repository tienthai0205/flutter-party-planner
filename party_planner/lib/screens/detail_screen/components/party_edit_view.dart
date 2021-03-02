import 'package:flutter/material.dart';
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
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight * 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25.0),
        child: SingleChildScrollView(
          child: Form(
            child: Container(
              height: widget.screenHeight * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
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
                  ),
                  TextFormField(
                    style: kfontSecondary.copyWith(fontSize: ktextsm),
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kYellowTheme,
                    ),
                    width: widget.screenWidth * 0.7,
                    child: TextField(
                      style: kHeading2.copyWith(color: kDarkTheme),
                      decoration: InputDecoration(
                        hintText: "location",
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
                            child: Text(
                              "Time",
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
                            child: Text(
                              "Date",
                              style: kHeading3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InviteesListView(screenHeight: widget.screenHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedButton3Sides(
                        text: "Cancle",
                        onPress: () {},
                        side: 'bottom',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RoundedButton3Sides(
                        text: "Save",
                        onPress: () {},
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
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
}
