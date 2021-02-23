import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:party_planner/constants.dart';

class PartyDetailScreem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -25,
            child: Container(
              height: screenHeight * 0.45,
              child: Image.network(
                'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2700&q=80',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      color: Color(0xff1F1F1F),
                      offset: Offset(0, 0),
                    ),
                  ],
                  color: kDarkTheme),
              height: screenHeight * 0.7,
              width: screenWidth,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Champagne Lux Sips",
                      style: kHeading.copyWith(fontSize: 20),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kYellowTheme,
                      ),
                      width: screenWidth * 0.7,
                      child: ListTile(
                        title: Text(
                          "3 Beverly Hills,  LA",
                          style: kfontSecondary.copyWith(
                              fontWeight: FontWeight.w700, fontSize: ktextsm2),
                        ),
                        leading: Icon(
                          Icons.location_on,
                          color: kDarkTheme,
                        ),
                      ),
                    ),
                    Container(
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
                                  style: kfontSecondary.copyWith(
                                      color: kLightTheme),
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
                                  style: kfontSecondary.copyWith(
                                      color: kLightTheme),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        "Join this amazing party where we have awesome music with special guests none other than: Mike Music, Sandra Song, Billy Boombox and Cara Caraoke!",
                        style: kfontSecondary.copyWith(color: kLightTheme),
                      ),
                    ),
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
                          leading:
                              SvgPicture.asset("assets/icons/profile_icon.svg"),
                          trailing: Icon(
                            Icons.cancel_outlined,
                            color: Color(0xffE84A5F),
                          ),
                        ),
                        itemCount: 10,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text("Cancel"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(22),
                                topRight: Radius.circular(22),
                                bottomRight: Radius.circular(22),
                              ),
                            ),
                            color: Color(0xff6F6F6F),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text("Save"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(22),
                                bottomLeft: Radius.circular(22),
                                bottomRight: Radius.circular(22),
                              ),
                            ),
                            color: kYellowTheme,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
