import 'package:flutter/material.dart';
import 'package:party_planner/constants.dart';

class RoundedButton3Sides extends StatelessWidget {
  const RoundedButton3Sides({Key key, this.text, this.onPress, this.side})
      : super(key: key);

  final String text;
  final Function onPress;
  final String side;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FlatButton(
        onPressed: onPress,
        child: Text(text),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: side == 'top' ? Radius.zero : Radius.circular(22),
            bottomRight: Radius.circular(22),
            bottomLeft: side == 'bottom' ? Radius.zero : Radius.circular(22),
          ),
        ),
        color: side == 'bottom' ? Color(0xff6F6F6F) : kYellowTheme,
      ),
    );
  }
}
