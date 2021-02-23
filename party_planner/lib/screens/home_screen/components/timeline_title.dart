import 'package:flutter/material.dart';

import '../../../constants.dart';

class TimelineTitle extends StatelessWidget {
  const TimelineTitle({Key key, @required this.screenWidth, this.text})
      : super(key: key);

  final double screenWidth;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          color: kLightTheme,
          thickness: 0.8,
        ),
        Container(
          color: kDarkTheme,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              text,
              style: kHeading3,
            ),
          ),
        ),
      ],
    );
  }
}
