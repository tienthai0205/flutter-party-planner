import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class InviteesListView extends StatelessWidget {
  const InviteesListView({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

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
          height: screenHeight / 6,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemBuilder: (_, index) => ListTile(
              title: Text("Ruud"),
              leading: SvgPicture.asset("assets/icons/profile_icon.svg"),
              trailing: Icon(
                Icons.cancel_outlined,
                color: Color(0xffE84A5F),
              ),
            ),
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
