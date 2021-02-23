import 'package:flutter/material.dart';
import 'package:party_planner/screens/home_screen/home_screen.dart';
import 'package:party_planner/screens/landing_screen.dart';

Map routes = <String, WidgetBuilder>{
  'splash_screen': (BuildContext context) => LandingScreen(),
  'home_screen': (BuildContext context) => HomeScreen(),
  // 'feed_screen': (BuildContext context) => FeedScreen(),
  // 'splash_screen': (BuildContext context) => SplashScreen()
};
