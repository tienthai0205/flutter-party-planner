import 'package:flutter/material.dart';
import 'package:party_planner/constants.dart';

class RoundedBorderButton extends StatelessWidget {
  RoundedBorderButton(
      {Key key, this.text, this.onPressFunction, this.width, this.height});

  final Text text;
  final Function onPressFunction;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: onPressFunction,
      child: text,
      color: kDarkGreen,
      minWidth: width,
      height: height,
    );
  }
}
