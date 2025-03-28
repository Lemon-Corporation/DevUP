import 'package:flutter/material.dart';
import 'package:devup/Data/data_model.dart';
import 'package:devup/Screens/Dashboard/dashboard.dart';
import 'package:devup/Screens/Dashboard/notifications.dart';
import 'package:devup/Screens/Dashboard/search_screen.dart';
import 'package:devup/Values/values.dart';

String tabSpace = "\t\t\t";

final List<Widget> dashBoardScreens = [
  Dashboard(),
  NotificationScreen(),
  SearchScreen()
];

List<Color> progressCardGradientList = [
  //grenn
  HexColor.fromHex("87EFB5"),
  //blue
  HexColor.fromHex("8ABFFC"),
  //pink
  HexColor.fromHex("EEB2E8"),
];
