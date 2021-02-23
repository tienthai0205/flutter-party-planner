import 'package:flutter/material.dart';

import '../../../constants.dart';

class PartyDetailTimeCard extends StatelessWidget {
  const PartyDetailTimeCard({
    Key key,
  }) : super(key: key);

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
                  "21:00",
                  style: kfontSecondary.copyWith(color: kLightTheme),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_rounded,
                color: kLightTheme,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "21-3-2021",
                  style: kfontSecondary.copyWith(color: kLightTheme),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
