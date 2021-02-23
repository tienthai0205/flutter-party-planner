import 'package:flutter/material.dart';

class PartyHeroImage extends StatelessWidget {
  const PartyHeroImage({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -25,
      child: Container(
        height: screenHeight * 0.45,
        child: Image.network(
          'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2700&q=80',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
