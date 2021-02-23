import 'package:flutter/material.dart';

import '../../../constants.dart';

class PartyHeroImage extends StatelessWidget {
  const PartyHeroImage({
    Key key,
    @required this.screenHeight,
    @required this.imageLink,
  }) : super(key: key);

  final double screenHeight;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -25,
      child: Container(
        height: screenHeight * 0.45,
        child: Image.network(
          imageLink != null ? imageLink : imagePlaceholder,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
