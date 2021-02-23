import 'package:flutter/material.dart';

class RoundedButton3Sides extends StatelessWidget {
  const RoundedButton3Sides({Key key, this.text, this.onPress})
      : super(key: key);

  final String text;
  final Function onPress;

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
            topRight: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
        ),
        color: Color(0xff6F6F6F),
      ),
    );
  }
}
