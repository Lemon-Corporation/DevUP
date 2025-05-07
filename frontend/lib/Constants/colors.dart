import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static fromHex(String hexColor) {
    return HexColor(hexColor);
  }
}

// App colors
const Color kPrimaryColor = Color(0xFF6C63FF);
const Color kSecondaryColor = Color(0xFF00BFA6);
const Color kAccentColor = Color(0xFFFFA726);
const Color kErrorColor = Color(0xFFE57373);
const Color kTextColor = Color(0xFF333333);
const Color kLightTextColor = Color(0xFF6A7280);
const Color kBackgroundColor = Color(0xFFF8F9FA); 