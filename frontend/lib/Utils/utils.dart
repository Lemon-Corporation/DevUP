import 'package:flutter/material.dart';

class Utils {
  // Статические размеры экрана (будут инициализированы в main.dart)
  static double screenWidth = 0;
  static double screenHeight = 0;
  
  // Метод для инициализации размеров экрана
  static void initScreenSize(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  // Утилиты для работы с цветами
  static Color hexToColor(String hex) {
    assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
        'hex color must be #rrggbb or #rrggbbaa');

    return Color(
      int.parse(hex.substring(1), radix: 16) +
          (hex.length == 7 ? 0xff000000 : 0x00000000),
    );
  }

  // Утилиты для работы с размерами экрана (с контекстом)
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Утилиты для работы с отступами
  static EdgeInsets paddingAll(double value) {
    return EdgeInsets.all(value);
  }

  static EdgeInsets paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static EdgeInsets paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  // Утилиты для работы с размерами
  static SizedBox sizedBoxHeight(double height) {
    return SizedBox(height: height);
  }

  static SizedBox sizedBoxWidth(double width) {
    return SizedBox(width: width);
  }

  // Утилиты для работы с радиусами
  static BorderRadius borderRadius(double radius) {
    return BorderRadius.circular(radius);
  }

  static BorderRadius borderRadiusOnly({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      topRight: Radius.circular(topRight),
      bottomLeft: Radius.circular(bottomLeft),
      bottomRight: Radius.circular(bottomRight),
    );
  }
} 
